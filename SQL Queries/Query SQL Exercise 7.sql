WITH first_messages AS(
	SELECT order_id, sender_app_type, message_sent_time AS msg_time,
		   ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY message_sent_time ASC) as ranking
	FROM customer_courier_chat_messages
),
first_reply AS(
	SELECT m.order_id, m.message_sent_time AS reply_time
	FROM customer_courier_chat_messages m
	JOIN first_messages fm ON m.order_id = fm.order_id AND fm.ranking = 1
	WHERE m.sender_app_type != fm.sender_app_type
		AND m.message_sent_time > fm.msg_time
)
SELECT fm.order_id,
	   ROUND(EXTRACT(EPOCH FROM (MIN(fr.reply_time) - fm.msg_time)), 2) AS response_delay_seconds
FROM first_messages fm
JOIN first_reply fr ON fm.order_id = fr.order_id
WHERE fm.ranking = 1
GROUP BY fm.order_id, fm.msg_time;