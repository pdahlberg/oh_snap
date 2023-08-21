--
-- Class User as table app_user
--

CREATE TABLE "app_user" (
  "id" serial,
  "username" text NOT NULL,
  "matricaid" text NOT NULL,
  "matricaAccessToken" text NOT NULL,
  "matricaRefreshToken" text NOT NULL,
  "credits" integer NOT NULL,
  "createdAt" timestamp without time zone NOT NULL,
  "modifiedAt" timestamp without time zone NOT NULL
);

ALTER TABLE ONLY "app_user"
  ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- Class AuthState as table auth_state
--

CREATE TABLE "auth_state" (
  "id" serial,
  "state" text NOT NULL,
  "codeverifier" text NOT NULL,
  "codechallenge" text NOT NULL,
  "url" text NOT NULL,
  "createdAt" timestamp without time zone NOT NULL,
  "modifiedAt" timestamp without time zone NOT NULL
);

ALTER TABLE ONLY "auth_state"
  ADD CONSTRAINT auth_state_pkey PRIMARY KEY (id);


--
-- Class Post as table post
--

CREATE TABLE "post" (
  "id" serial,
  "title" text,
  "text" text,
  "imageUrl" text,
  "captureurl" text,
  "filename" text NOT NULL,
  "shareUrl" text,
  "shareAltUrl" text,
  "address" text,
  "transactionId" text,
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
  "status" integer NOT NULL,
  "cost" integer NOT NULL,
  "paid" integer NOT NULL,
  "paymentRequirement" integer NOT NULL,
  "dependsOn" integer,
  "statusMsg" text,
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

