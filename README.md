# SaaS Support Data Lab – Mini Project

This project simulates a small SaaS support environment using a simple SQLite database. It includes:

- Users  
- Subscriptions  
- Support tickets  
- Login events  

The goal is to show how SQL can be used to troubleshoot common SaaS support issues such as login problems, billing questions, or account cancellations.

---

## Example SQL Queries

### 1. View all open tickets with user details

```sql
SELECT t.ticket_id, u.name, u.email, t.subject, t.created_at
FROM tickets t
JOIN users u ON t.user_id = u.user_id
WHERE t.status = 'open';
