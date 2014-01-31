# puppet stages are of limted use - but defining repositories at the right point seems to be valid
stage { 'last': }
Stage['main'] -> Stage['last']

# Basics
include base
# Stuff for RPMBUILD
include rpmbuild
# Stuff for nginx build
include nginxdevel
