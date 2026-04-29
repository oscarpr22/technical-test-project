SELECT c.*
FROM public.customer_courier_chat_messages c
ORDER BY c.message_sent_time ASC
LIMIT 1;