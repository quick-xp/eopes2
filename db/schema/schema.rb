create_table 'schema_migrations', collate: 'utf8_bin', comment: '' do |t|
  t.varchar 'version'

  t.index 'version', name: 'unique_schema_migrations', unique: true
end

create_table :ar_internal_metadata, collate: :utf8_bin do |t|
  t.varchar :key
  t.varchar :value
end
