-- SaaS Support Data Lab - schema + sample data

-- Drop tables if they already exist (for re-runs)
DROP TABLE IF EXISTS login_events;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS users;

-- 1) USERS
CREATE TABLE users (
  user_id       INTEGER PRIMARY KEY,
  name          TEXT NOT NULL,
  email         TEXT NOT NULL,
  created_at    DATE NOT NULL
);

-- 2) SUBSCRIPTIONS
CREATE TABLE subscriptions (
  sub_id        INTEGER PRIMARY KEY,
  user_id       INTEGER NOT NULL,
  plan          TEXT NOT NULL,   -- e.g. 'Basic', 'Pro'
  status        TEXT NOT NULL,   -- 'active', 'trial', 'canceled'
  started_at    DATE NOT NULL,
  canceled_at   DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 3) TICKETS
CREATE TABLE tickets (
  ticket_id     INTEGER PRIMARY KEY,
  user_id       INTEGER NOT NULL,
  subject       TEXT NOT NULL,
  status        TEXT NOT NULL,      -- 'open', 'pending', 'closed'
  created_at    DATE NOT NULL,
  closed_at     DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 4) LOGIN EVENTS
CREATE TABLE login_events (
  login_id      INTEGER PRIMARY KEY,
  user_id       INTEGER NOT NULL,
  login_time    DATETIME NOT NULL,
  success       INTEGER NOT NULL,   -- 1 = success, 0 = failed
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Seed data: USERS
INSERT INTO users (user_id, name, email, created_at) VALUES
(1, 'Alice Carter',   'alice@example.com',   '2024-01-10'),
(2, 'Bob Martin',     'bob@example.com',     '2024-02-02'),
(3, 'Cara Johnson',   'cara@example.com',    '2024-03-15'),
(4, 'Dave Lee',       'dave@example.com',    '2024-04-01'),
(5, 'Eva Rodriguez',  'eva@example.com',     '2024-04-20'),
(6, 'Frank Wilson',   'frank@example.com',   '2024-05-05');

-- Seed data: SUBSCRIPTIONS
INSERT INTO subscriptions (sub_id, user_id, plan, status, started_at, canceled_at) VALUES
(1, 1, 'Pro',     'active',   '2024-01-10', NULL),
(2, 2, 'Basic',   'canceled', '2024-02-02', '2024-05-01'),
(3, 3, 'Trial',   'active',   '2024-03-15', NULL),
(4, 4, 'Basic',   'active',   '2024-04-01', NULL),
(5, 5, 'Pro',     'canceled', '2024-04-20', '2024-06-15'),
(6, 6, 'Trial',   'trial',    '2024-05-05', NULL);

-- Seed data: TICKETS
INSERT INTO tickets (ticket_id, user_id, subject, status, created_at, closed_at) VALUES
(101, 1, 'Can’t log in',                   'closed', '2024-04-01', '2024-04-01'),
(102, 1, 'Billing question about Pro',     'open',   '2024-05-10', NULL),
(103, 2, 'Cancel my account',              'closed', '2024-04-28', '2024-04-29'),
(104, 3, 'Feature request: Dark mode',     'pending','2024-05-05', NULL),
(105, 4, 'App crashing on login',          'closed', '2024-05-15', '2024-05-16'),
(106, 5, 'Charged after cancellation',     'open',   '2024-06-20', NULL),
(107, 5, 'Export data request',            'closed', '2024-06-10', '2024-06-11'),
(108, 6, 'Trial extension request',        'open',   '2024-06-25', NULL);

-- Seed data: LOGIN EVENTS
INSERT INTO login_events (login_id, user_id, login_time, success) VALUES
(1, 1, '2024-04-01 09:00', 0),
(2, 1, '2024-04-01 09:02', 1),
(3, 2, '2024-04-28 10:15', 1),
(4, 1, '2024-05-10 08:30', 1),
(5, 3, '2024-05-05 11:00', 1),
(6, 4, '2024-05-15 09:45', 0),
(7, 4, '2024-05-15 09:47', 0),
(8, 4, '2024-05-15 09:50', 1),
(9, 5, '2024-06-20 07:55', 1),
(10, 6, '2024-06-25 13:20', 1);
