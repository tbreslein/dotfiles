(lambda plugin-setup [plugname tbl]
  `((. (require ,plugname) :setup) ,tbl))

(lambda telescope-load-extension [extension]
  `((. (require :telescope) :load_extension) ,extension))

{: plugin-setup : telescope-load-extension}
