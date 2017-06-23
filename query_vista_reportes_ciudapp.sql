CREATE OR REPLACE VIEW newbulk.ciudapp_reportes AS 
 SELECT request._id,
    request.address_string,
    request.deleted_at,
    request.description,
    request.requested_datetime,
    request.service,
    request.service_request_id,
    request.status,
    request.device_type,
    request.updated_datetime,
    request."position",
    service_categoria.id_categoria,
    service_categoria.service_categoria,
    service.service_name,
    service.description AS service_description,
    service.service_code
   FROM newbulk.request
     JOIN newbulk.service ON request.service::text = service._id::text
     LEFT JOIN newbulk.service_categoria ON service._id::text = service_categoria._id::text;
