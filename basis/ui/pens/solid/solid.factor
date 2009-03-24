! Copyright (C) 2009 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel accessors opengl math colors ui.pens ui.pens.caching ;
IN: ui.pens.solid

TUPLE: solid < caching-pen color interior-vertices boundary-vertices ;

: <solid> ( color -- solid ) solid new swap >>color ;

M: solid recompute-pen
    swap dim>>
    [ (fill-rect-vertices) >>interior-vertices ]
    [ (rect-vertices) >>boundary-vertices ]
    bi drop ;

<PRIVATE

: (solid) ( gadget pen -- )
    [ compute-pen ] [ color>> gl-color ] bi ;

PRIVATE>

M: solid draw-interior
    [ (solid) ] [ interior-vertices>> gl-vertex-pointer ] bi
    (gl-fill-rect) ;

M: solid draw-boundary
    [ (solid) ] [ boundary-vertices>> gl-vertex-pointer ] bi
    (gl-rect) ;

M: solid pen-background
    nip color>> dup alpha>> 1 number= [ drop transparent ] unless ;