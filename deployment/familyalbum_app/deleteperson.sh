#!/bin/bash
export PERSON_ID=\'$1\'
. /root/sourceme
psql -d familyalbum_dev -h familyalbum_db -U jamesb0nd -c " \
    delete from country_dvellers where person_id=$PERSON_ID ;
    delete from family_members where person_id=$PERSON_ID ;
    update person set father_id=DEFAULT where father_id=$PERSON_ID ;
    update person set mother_id=DEFAULT where mother_id=$PERSON_ID ;
    delete from person where id=$PERSON_ID ;
    "
