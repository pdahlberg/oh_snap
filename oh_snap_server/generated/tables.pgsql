--
-- Class Post as table post
--

CREATE TABLE "post" (
  "id" serial,
  "title" text,
  "text" text,
  "imageUrl" text,
  "captureUrl" text,
  "shareUrl" text,
  "shareAltUrl" text,
  "address" text,
  "createdAt" timestamp without time zone NOT NULL,
  "modifiedAt" timestamp without time zone NOT NULL
);

ALTER TABLE ONLY "post"
  ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Class Task as table task
--

CREATE TABLE "task" (
  "id" serial,
  "postId" integer NOT NULL,
  "type" integer NOT NULL,
  "cost" integer NOT NULL,
  "paid" integer NOT NULL,
  "paymentRequirement" integer NOT NULL,
  "dependsOn" integer,
  "createdAt" timestamp without time zone NOT NULL,
  "modifiedAt" timestamp without time zone NOT NULL
);

ALTER TABLE ONLY "task"
  ADD CONSTRAINT task_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "task"
  ADD CONSTRAINT task_fk_0
    FOREIGN KEY("postId")
      REFERENCES post(id)
        ON DELETE CASCADE;

