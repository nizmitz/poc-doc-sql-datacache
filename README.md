# poc-doc-sql-datacache

This repository is used to host tf codes for poc the default behavior that wasn't captured in terraform documentation

## First test ( terraform plan, terraform apply)
* cache-null-ent > no data_cache, this is expected because ent doesn't support it
* cache-disabled-ent-plus > no data_cache, since we explicitly said to disable the datacache
* cache-enabled-ent-plus > data_cache is enabled as we explicitly enable it
cache-enabled-ent-plus-sql-server > data_cache is enabled as we explicitly enable it opposed from the documentation
* cache-null-ent-plus > data_cache is enabled, this is due to the default of true when null value is given

## Second test ( manual changes, then terraform plan )
* cache-null-ent-plus > disable data_cache manually then try to plan again
* cache-enabled-ent-plus > disable data_cache manually then try to plan again

## Result
* cache-null-ent-plus >  it detected the drift, but doesn't try to force the data_cache to be enable once again
* cache-enabled-ent-plus > it detected the drift and created a plan to rectify it

## Conclusion
for null values, it will basically default to enable the data_cache enabled, but it doesn't force it to be enabled in subsequent plans/apply

not as per the TF documentation SQL Server is also able to be created with data_cache