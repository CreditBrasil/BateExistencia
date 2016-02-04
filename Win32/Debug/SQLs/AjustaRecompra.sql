--Ajusta recebíveis recomprados
update petra.PetraExistencia set ingCodigo = i.ingCodigo, AtualizadoEm = GetDate()
from
  petra.PetraExistencia e (nolock)
  join nfIngressos i (nolock) on e.empCodigo = i.empCodigo and e.ingCodigo = i.ingCodigoRecompra
where
  i.ingCodigoRecompra is not null
  and e.empCodigo = %0:d;