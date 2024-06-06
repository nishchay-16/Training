Table partitioning in PostgreSQL allows you to divide large tables into smaller, more manageable pieces, called partitions. 
Each partition can be stored separately, which can improve query performance, simplify data management, and enhance data archiving and purging processes
This can improve performance and manageability, especially for tables with a large amount of data.



PostgreSQL supports several types of table partitioning methods:

Range Partitioning:-> 
In range partitioning, rows are distributed across partitions based on a range of values from one or more columns. 
For example, you could partition a table of sales data by month, with each partition containing data for a specific month.

List Partitioning: ->
List partitioning involves dividing the table based on specific values from one or more columns.
Each partition represents a distinct list of values. 
For instance, you could partition a table of customer data by country, with each partition containing data for customers from a particular country.

Hash Partitioning: ->
Hash partitioning distributes rows across partitions based on a hash value computed from one or more columns. 
This method is useful for distributing data evenly across partitions when there is not a clear range or list to partition by.

Composite Partitioning: ->
Composite partitioning combines multiple partitioning methods. 
For example, you might use range partitioning to partition data by date range within each list partition representing a region.

Multi-Level Partitioning:->
This involves partitioning a table multiple times, creating a hierarchy of partitions. 
For instance, you could partition a table by year at the top level, then further partition each year by month.



Implementation:--->  (BASED ON RANGE)

Table Partitioning (waiting_list_id)   

-- Create the partitioned table
CREATE TABLE subscribers_part (
    LIKE subscribers
)
PARTITION BY RANGE (waiting_list_id);



-- Define the ranges for partitioning
CREATE TABLE subscribers_part_1 PARTITION OF subscribers_part FOR VALUES FROM (1) TO (6000);
CREATE TABLE subscribers_part_2 PARTITION OF subscribers_part FOR VALUES FROM (6001) TO (9000);
CREATE TABLE subscribers_part_3 PARTITION OF subscribers_part FOR VALUES FROM (9001) TO (12000);
CREATE TABLE subscribers_part_4 PARTITION OF subscribers_part FOR VALUES FROM (12001) TO (15000);
CREATE TABLE subscribers_part_5 PARTITION OF subscribers_part FOR VALUES FROM (15001) TO (18000);

-- Create a default partition for rows with NULL values for "waiting_list_id" 
CREATE TABLE subscribers_part_default PARTITION OF subscribers_part DEFAULT;




-- Finally, move the data from the original table into the partitioned table
INSERT INTO subscribers_part
SELECT *
FROM subscribers;



-- Create indexes on the partitioned table
CREATE INDEX index_subscribers_part_on_code ON subscribers_part (code);
CREATE INDEX index_subscribers_part_on_email ON subscribers_part (email);
CREATE INDEX index_subscribers_part_on_gid ON subscribers_part (gid);
CREATE INDEX index_subscribers_part_on_position_code ON subscribers_part (position_code);
CREATE INDEX index_subscribers_part_on_referral_id ON subscribers_part (referral_id);
CREATE INDEX index_subscribers_part_on_referral_id_referred_verified ON subscribers_part (referral_id, referred, verified);
CREATE INDEX index_subscribers_part_on_referrer_code ON subscribers_part (referrer_code);
CREATE INDEX index_subscribers_part_on_verified_token ON subscribers_part (verified_token);
CREATE INDEX index_subscribers_part_on_waiting_list_id ON subscribers_part (waiting_list_id);
CREATE INDEX index_subscribers_part_on_waiting_list_id_and_code ON subscribers_part (waiting_list_id, code);
CREATE INDEX index_subscribers_part_on_waiting_list_id_and_normalised_email ON subscribers_part (waiting_list_id, normalised_email);
CREATE INDEX index_subscribers_part_on_waiting_list_id_and_position_code ON subscribers_part (waiting_list_id, position_code);
CREATE INDEX index_subscribers_part_on_waiting_list_id_and_status ON subscribers_part (waiting_list_id, status);
CREATE INDEX index_subscribers_part_on_waiting_list_id_and_verified ON subscribers_part (waiting_list_id, verified);

CREATE INDEX idx_subscribers_part_id ON subscribers_part (id);



-- Setting all the default values in the partitioned table
ALTER TABLE subscribers_part ALTER COLUMN id SET DEFAULT nextval('subscribers_id_seq'::regclass); 
ALTER TABLE subscribers_part ALTER COLUMN referred SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN points SET DEFAULT 1;
ALTER TABLE subscribers_part ALTER COLUMN status SET DEFAULT 'registered'::character varying;
ALTER TABLE subscribers_part ALTER COLUMN verified SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN referral_points SET DEFAULT 1;
ALTER TABLE subscribers_part ALTER COLUMN bounced SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN people_referred SET DEFAULT 0;
ALTER TABLE subscribers_part ALTER COLUMN risk_level SET DEFAULT 0;
ALTER TABLE subscribers_part ALTER COLUMN approved SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN sms_verified SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN events_referred SET DEFAULT 0;
ALTER TABLE subscribers_part ALTER COLUMN is_quick_add_referral SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN phone_number SET DEFAULT ''::character varying;
ALTER TABLE subscribers_part ALTER COLUMN crypto_wallet_address SET DEFAULT ''::character varying;
ALTER TABLE subscribers_part ALTER COLUMN crypto_wallet_provider SET DEFAULT ''::character varying;
ALTER TABLE subscribers_part ALTER COLUMN other_identifier_value SET DEFAULT ''::character varying;
ALTER TABLE subscribers_part ALTER COLUMN verify_email SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN email_verified SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN is_high_risk_referrer SET DEFAULT false;
ALTER TABLE subscribers_part ALTER COLUMN pending_referrals SET DEFAULT 0;
ALTER TABLE subscribers_part ALTER COLUMN unconfirmed_referrals SET DEFAULT 0;
ALTER TABLE subscribers_part ALTER COLUMN people_visitors SET DEFAULT 0;
ALTER TABLE subscribers_part ALTER COLUMN coupon_details SET DEFAULT ''::hstore;
ALTER TABLE subscribers_part ALTER COLUMN lifetime_spend SET DEFAULT 0.0;
ALTER TABLE subscribers_part ALTER COLUMN stage_passed SET DEFAULT '{}'::character varying[];
ALTER TABLE subscribers_part ALTER COLUMN promoted SET DEFAULT false;



-- Creating foreign_key relation with Transaction table
ALTER TABLE subscribers_part
ADD CONSTRAINT subscribers_part_id_waiting_list_id_unique 
UNIQUE (id, waiting_list_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_subscribers_part 
FOREIGN KEY (subscriber_id, waiting_list_id) 
REFERENCES subscribers_part(id, waiting_list_id);



-- Rename Table
ALTER TABLE subscribers RENAME TO subscribers_temp;
ALTER TABLE subscribers_part RENAME TO subscribers;