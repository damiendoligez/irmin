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

module type S = sig
  include Tc.S0
  type contents
  type node
  type commit
  type tag
  val create: unit -> t Lwt.t
  val add_contents: t -> contents -> unit Lwt.t
  val add_node: t -> node -> unit Lwt.t
  val add_commit: t -> commit -> unit Lwt.t
  val add_tag: t -> tag -> unit Lwt.t
  val iter_contents: t -> (contents -> unit Lwt.t) -> unit Lwt.t
  val iter_nodes: t -> (node -> unit Lwt.t) -> unit Lwt.t
  val iter_commits: t -> (commit -> unit Lwt.t) -> unit Lwt.t
  val iter_tags: t -> (tag -> unit Lwt.t) -> unit Lwt.t
end

module Make
    (C: Ir_contents.STORE)
    (N: Ir_node.STORE)
    (H: Ir_commit.STORE)
    (T: Ir_tag.STORE):
  S with type contents = C.key * C.value
     and type node = N.key * N.value
     and type commit = H.key * H.value
     and type tag = T.key * T.value
