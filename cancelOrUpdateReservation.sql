
UPDATE Reservations
SET status = 'cancelled'
WHERE reservation_id = 1  /* id de la reserva que se quiere actualizar*/
  AND user_id = 32   /* usuario que quiere cancelar la reserva*/
  AND status = 'confirmed';
