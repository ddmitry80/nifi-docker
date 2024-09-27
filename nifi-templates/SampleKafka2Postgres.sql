CREATE TABLE IF NOT EXISTS public.samplekafka2postgres (
	id serial4 NOT NULL,
	ins_dttm timestamptz DEFAULT now() NOT NULL,
	dttm timestamptz NULL,
	txt text NULL,
	CONSTRAINT samplekafka2postgres_pkey PRIMARY KEY (id)
);

delete from samplekafka2postgres
where dttm < now() - interval '5 minute'; 
