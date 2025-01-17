(* File generated from hash.idl *)
(* This file is part of the MLCUDDIDL Library, released under LGPL license.
   Please read the COPYING file packaged in the distribution  *)

(** User hashtables *)

type t
  (** Abstract type for user hashtables *)

external _create : int -> int -> t
	= "camlidl_cudd_hash__create"

external arity : t -> int
	= "camlidl_cudd_hash_arity"

external clear : t -> unit
	= "camlidl_cudd_hash_clear"


let (table:t Weak.t ref) = ref (Weak.create 32)

let create ?(size=2) arity =
  let hash = _create arity size in
  let index = ref 0 in
  while
    !index < Weak.length !table
    && Weak.check !table !index
  do
    incr index
  done;
  if !index = Weak.length !table then begin
    let newtable = Weak.create (2* !index) in
    Weak.blit !table 0 newtable 0 !index;
    table := newtable;
  end;
  Weak.set !table !index (Some (Obj.magic hash));
  hash

let clear_all () =
  for i=0 to (Weak.length !table)-1 do
    let ohash = Weak.get_copy !table i in
    match ohash with
      | None -> ()
      | Some hash -> clear hash
  done;
  ()

let _ = Callback.register "camlidl_cudd_hash_clear_all" clear_all

