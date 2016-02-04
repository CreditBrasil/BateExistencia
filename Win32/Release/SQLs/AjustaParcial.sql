--Ajusta recebíveis liquidados parcialmente
update petra.PetraExistencia set ingCodigo = i.ingCodigoParcial, AtualizadoEm = GetDate()
from
  petra.PetraExistencia e (nolock)
  join nfIngressos i (nolock) on e.empCodigo = i.empCodigo and e.ingCodigo = i.ingCodigo
where
  i.ingCodigoParcial is not null
  and e.empCodigo = %0:d;