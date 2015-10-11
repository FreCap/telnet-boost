#!/bin/bash

cd ./ext/boost_1_59_0/


./bootstrap.sh --includedir=../../include --libdir=../../libs --with-libraries=system,thread,date_time,regex,serialization runtime-link=static


./b2 link=static install

cd ../../
