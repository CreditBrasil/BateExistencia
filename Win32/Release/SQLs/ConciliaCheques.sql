--Concilia cheques
update petra.PetraExistencia set ingCodigo = i.ingCodigo, AtualizadoEm = GetDate()
from
  petra.PetraExistencia e (nolock)
  join nfIngressos i (nolock) on (e.empCodigo = i.empCodigo)
  join nfOperacaoTitulo t (nolock) on (i.empCodigo = t.empCodigo and i.opetitCodigo = t.opetitCodigo and e.Cmc7 = t.opeTitCmc7)
  join nfCedente c (nolock) on (i.empCodigo = c.empCodigo and i.cedCodigo = c.cedCodigo and e.OriginadorCnpjCpf = c.pesCNPJCPF)
where
  e.TipoTitulo = 1
  and e.empCodigo = %0:d
  and e.ingCodigo is null
  and i.ingCodigoParcial is null
  and i.ingCodigo in (select min(i.ingCodigo) from
	  petra.PetraExistencia e (nolock)
	  join nfIngressos i (nolock) on (e.empCodigo = i.empCodigo)
	  join nfOperacaoTitulo t (nolock) on (i.empCodigo = t.empCodigo and i.opetitCodigo = t.opetitCodigo and e.Cmc7 = t.opeTitCmc7)
	  join nfCedente c (nolock) on (i.empCodigo = c.empCodigo and i.cedCodigo = c.cedCodigo and e.OriginadorCnpjCpf = c.pesCNPJCPF)
	where
	  e.TipoTitulo = 1
      and e.empCodigo = %0:d
	  and e.ingCodigo is null
      and i.ingCodigoParcial is null
	group by c.pesCNPJCPF, t.opeTitCmc7
	having count(*) = 1);