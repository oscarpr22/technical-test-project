WITH courier_messages AS (
    SELECT 
        order_id, 
        MIN(message_sent_time) AS cour_first_timest,
        COUNT(*) AS cour_num_mess
    FROM customer_courier_chat_messages
    WHERE sender_app_type LIKE 'Courier%'
    GROUP BY order_id
),
customer_messages AS (
    SELECT 
        order_id, 
        MIN(message_sent_time) AS cust_first_timest,
        COUNT(*) AS cust_num_mess
    FROM customer_courier_chat_messages
    WHERE sender_app_type LIKE 'Customer%'
    GROUP BY order_id
),
first_last_messages AS (
    SELECT DISTINCT order_id,
        CASE WHEN 
			FIRST_VALUE(sender_app_type) OVER(PARTITION BY order_id ORDER BY message_sent_time ASC) LIKE 'Courier%' THEN 'Courier' 
			ELSE 'Customer' 
			END AS first_sender,
        FIRST_VALUE(message_sent_time) OVER(PARTITION BY order_id ORDER BY message_sent_time ASC) AS first_timestamp,
        FIRST_VALUE(message_sent_time) OVER(PARTITION BY order_id ORDER BY message_sent_time DESC) AS last_timestamp,
        FIRST_VALUE(order_stage) OVER(PARTITION BY order_id ORDER BY message_sent_time DESC) AS last_order_stage
    FROM customer_courier_chat_messages
)
SELECT 
	o.order_id,
	o.city_code,
	come.cour_first_timest AS first_courier_message,
	cume.cust_first_timest AS first_customer_message,
	COALESCE(come.cour_num_mess, 0) AS num_messages_courier,
	COALESCE(cume.cust_num_mess, 0) AS num_messages_customer,
	flm.first_sender AS first_message_by,
	flm.first_timestamp AS conversation_started_at,
	ROUND(ABS(EXTRACT(EPOCH FROM (come.cour_first_timest - cume.cust_first_timest))), 2) AS first_responsetime_delay_seconds,
	flm.last_timestamp AS last_message_time,
	flm.last_order_stage AS last_message_order_stage
FROM orders o
LEFT JOIN courier_messages come
ON o.order_id = come.order_id
LEFT JOIN customer_messages cume
ON o.order_id = cume.order_id
LEFT JOIN first_last_messages flm
ON o.order_id=flm.order_id;