k view-secret -a learner-user.dataops-bootcamp-postgresql.credentials.postgresql.acid.zalan.do
export PGDATABASE=learner
export PGUSER=learner_user
export PGPORT=7432
export PGPASSWORD=
kpf dataops-bootcamp-postgresql-0 7432:5432
