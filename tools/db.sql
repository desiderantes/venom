-- Parse::SQL::Dia     version 0.27                              
-- Documentation       http://search.cpan.org/dist/Parse-Dia-SQL/
-- Environment         Perl 5.018002, /usr/bin/perl              
-- Architecture        x86_64-linux-gnu-thread-multi             
-- Target Database     sqlite3                                   
-- Input file          db.dia                                    
-- Generated at        Tue Sep 22 12:45:05 2015                  
-- Typemap for sqlite3 not found in input file                   

-- get_constraints_drop 

-- get_permissions_drop 

-- get_view_drop

-- get_schema_drop
drop table if exists messages;
drop table if exists contact;

-- get_smallpackage_pre_sql 

-- get_schema_create

-- A Tox Message
create table messages (
   message_id          BIGINT      not null,
   message_sender_id   VARCHAR(72) not null references contact (contact_address),--  Public key of the sender
   message_receiver_id VARCHAR(72) not null references contact (contact_address),--  The public key of the receiver
   message_type        SMALLSERIAL not null,--  The MessageType
   message_timestamp   TIMESTAMP   not null,--  Timestamp of the message
   message_text        TEXT        not null,--  The message per se
   constraint pk_messages primary key (message_id)
)   ;

-- A Tox user representing a contact
create table contact (
   contact_address        VARCHAR(72) not null,--  The contact Tox Address
   contact_name           TEXT                ,--  The contact name
   contact_alias          TEXT                ,--  An enforced alias by the User
   contact_tox_id         BIGINT      not null,--  The internal toxcore id
   contact_last_seen      TIMESTAMP   not null,--  Last time this buddy ever interacted with us
   contact_status_message TEXT                ,--  The contact's custom status message
   contact_is_silenced    BOOLEAN     not null,--  Wether the contact is silenced or not
   constraint pk_contact primary key (contact_address,contact_tox_id)
)   ;

-- get_view_create

-- get_permissions_create

-- get_inserts

-- get_smallpackage_post_sql

-- get_associations_create
