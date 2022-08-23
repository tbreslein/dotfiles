(lambda plugin-setup [plugname tbl]
  `((. (require ,plugname) :setup) ,tbl))

{: plugin-setup}
