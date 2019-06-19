#!/usr/bin/env bash
 
# The installation script of PSCyr package (for texlive system).
 
# On Ubuntu 13.10 it equals to '/usr/share/texlive/texmf-dist'
TEXMF=`kpsewhich -expand-var='$TEXMFMAIN'`
 
echo "###> Installing PSCyr to '$TEXMF' folder"
 
mkdir -p $TEXMF/{tex/latex,fonts/tfm/public,fonts/vf/public,fonts/type1/public,fonts/afm/public,doc/fonts,fonts/enc,fonts/map/dvips}/pscyr
 
# tweak from http://welinux.ru/post/3200/
mkdir fonts/map fonts/enc
mv dvips/config/*.map fonts/map
mv dvips/base/*.enc fonts/enc
cp fonts/enc/* $TEXMF/fonts/enc/pscyr
cp fonts/map/* $TEXMF/fonts/map/dvips/pscyr
# endtweak
 
cp tex/latex/pscyr/* $TEXMF/tex/latex/pscyr
cp fonts/tfm/public/pscyr/* $TEXMF/fonts/tfm/public/pscyr
cp fonts/vf/public/pscyr/* $TEXMF/fonts/vf/public/pscyr
cp fonts/type1/public/pscyr/* $TEXMF/fonts/type1/public/pscyr
cp fonts/afm/public/pscyr/* $TEXMF/fonts/afm/public/pscyr
cp LICENSE doc/README.koi doc/PROBLEMS $TEXMF/doc/fonts/pscyr
 
VARTEXFONTS=`kpsewhich -expand-var='$VARTEXFONTS'`
rm -f $VARTEXFONTS/pk/modeless/public/pscyr/*
 
# Next, we need to add pscyr to updmap.cfg
echo "Map pscyr.map" >> $TEXMF/web2c/updmap.cfg
 
echo "###> Updating file lists"
mktexlsr
 
echo "###> Running updmap"
updmap-sys