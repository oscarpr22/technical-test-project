SELECT c.*, o.city_code
FROM public.customer_courier_chat_messages c
JOIN public.orders o
ON c.order_id=o.order_id
ORDER BY o.city_code;