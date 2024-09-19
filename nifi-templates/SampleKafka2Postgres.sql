create table if not exists samplekafka2postgres (
	id serial primary key,
	dttm TIMESTAMPTZ,
	txt text
);

delete from samplekafka2postgres
where dttm < now() - interval '5 minute'; 
