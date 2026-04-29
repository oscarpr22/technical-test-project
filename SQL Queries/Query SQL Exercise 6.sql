WITH ranked_messages AS(
	SELECT *,
	ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY message_sent_time DESC) AS ranking
	FROM public.customer_courier_chat_messages
)

SELECT *
FROM ranked_messages
WHERE ranking = 1;