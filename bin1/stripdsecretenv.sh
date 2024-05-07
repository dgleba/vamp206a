
# WAS  stripsecretenv.sh  NOW  stripdsecretenv.sh

# ssenv

stripsecret(){

  # strip secrets from .env file for example file.
  # don't match # commented lines with preceding whitespace , /^[ \t]*#/!   then substitute all after = with xyzzz s/=.*/=xyzz/

  ssfile=".env"
  sed '/^[ \t]*#/!s/=.*/=xyzz/' $ssfile  > example-stripd$ssfile

  # no not this
  # grep -v "^#"  $ssfile | grep '=' | sed  's/=.*/=xyzz/' > example-stripd$ssfile
}

stripsecret