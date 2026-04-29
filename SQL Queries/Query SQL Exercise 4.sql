SELECT
	order_id,
	COUNT(*) AS customer_sent_messages
FROM public.customer_courier_chat_messages
WHERE sender_app_type LIKE 'Customer%'
GROUP BY order_id;