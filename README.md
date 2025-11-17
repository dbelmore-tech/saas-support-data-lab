# SaaS Support Data Lab – Mini Project

This project uses a small SQLite database to demonstrate how SQL can help troubleshoot common SaaS support issues. The dataset includes:

- Users  
- Subscriptions  
- Support tickets  
- Login events  

These examples show typical queries a SaaS support specialist might use to investigate customer issues.

---

## Example Queries

**1. Find all open support tickets with customer details**

```sql
SELECT t.ticket_id, u.name, u.email, t.subject, t.created_at
FROM tickets t
JOIN users u ON t.user_id = u.user_id
WHERE t.status = 'open';
```

**2. Review a user’s recent login attempts**

```sql
SELECT u.email, l.login_time, l.success
FROM login_events l
JOIN users u ON l.user_id = u.user_id
WHERE u.email = 'alice@example.com'
ORDER BY l.login_time DESC;
```

**3. Identify canceled accounts with billing-related tickets**

```sql
SELECT u.name, u.email, s.plan, s.canceled_at, t.subject
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
JOIN tickets t ON t.user_id = u.user_id
WHERE s.status = 'canceled'
  AND t.subject LIKE '%billing%';
```

---

## Files Included

- **saas_support_lab.db** — complete SQLite database  
- **sql/saas_support_lab.sql** — schema and sample data  

---

## Purpose

This project provides a simple demonstration of using relational data and SQL to support technical troubleshooting in a SaaS environment.
