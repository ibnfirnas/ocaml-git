(*
 * Copyright (c) 2013-2014 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

(** Lwt_unix IO module. *)

open Core_kernel.Std
open Git

val realpath: string -> string
(** Very dumb real-path. Only works for existing directories. *)

val mkdir: string -> unit Lwt.t
(** Create a directory (and the parent dirs if needed). *)

val directories: string -> string list Lwt.t
(** List the subdirs. *)

val files: string -> string list Lwt.t
(** List the subfiles. *)

val rec_files: string -> string list Lwt.t
(** List of the subfiles, recursively. *)

val read_file: string -> Bigstring.t
(** mmap a file and return a mutable C-like structure with its
    contents. *)

val write_file_string: string -> contents:string -> unit Lwt.t
(** Write a bigarray to a file. *)

val write_file: string -> Bigstring.t -> unit Lwt.t
(** Write a bigarray to a file. *)

val writev_file: string -> Bigstring.t list -> unit Lwt.t
(** Write a list of bigarrays to a file. *)

include Remote.IO
  with type ic = Lwt_io.input_channel
   and type oc = Lwt_io.output_channel

module Remote: functor (S: Store.S) -> Remote.S with type t = S.t
(** Implementation of the Git protocol using [Lwt_unix] and [Lwt_io]
    IO functions. *)
