--Concilia duplicatas com valor (original) e Sacado (apenas idg de compra)
update petra.PetraExistencia set ingCodigo = i.ingCodigo, AtualizadoEm = GetDate()
from
  petra.PetraExistencia e (nolock)
  join nfIngressos i (nolock) on (e.empCodigo = i.empCodigo and RTrim(LTrim(e.NumeroDocumento)) = Substring(RTrim(LTRim(i.ingDocumento)), 1, 10))
  join nfIdentificadorGlobal idg (nolock) on (i.idgCodigo = idg.idgCodigo)
  join nfFocoNegocio fn (nolock) on (idg.fneCodigo = fn.fneCodigo and fn.fneTipo = 'F')
  join nfOperacaoTitulo t (nolock) on (i.empCodigo = t.empCodigo and i.opetitCodigo = t.opetitCodigo and (t.opetitValor - coalesce(t.opetitDesconto, 0)) = e.ValorNominal)
  join nfCedente c (nolock) on (i.empCodigo = c.empCodigo and i.cedCodigo = c.cedCodigo and e.OriginadorCnpjCpf = c.pesCNPJCPF)
  join nfSacado s (nolock) on (i.empCodigo = s.empCodigo and i.sacCodigo = s.sacCodigo and e.SacadoCnpjCpf = s.pesCNPJCPF)
where
  e.TipoTitulo = 0
  and e.empCodigo = %0:d
  and e.ingCodigo is null
  and i.ingCodigoParcial is null
  and i.ingCodigo in (select min(i.ingCodigo)
	from
	  petra.PetraExistencia e
	  join nfIngressos i (nolock) on (e.empCodigo = i.empCodigo and RTrim(LTrim(e.NumeroDocumento)) = Substring(RTrim(LTRim(i.ingDocumento)), 1, 10))
	  join nfIdentificadorGlobal idg (nolock) on (i.idgCodigo = idg.idgCodigo)
	  join nfFocoNegocio fn (nolock) on (idg.fneCodigo = fn.fneCodigo and fn.fneTipo = 'F')
	  join nfOperacaoTitulo t (nolock) on (i.empCodigo = t.empCodigo and i.opetitCodigo = t.opetitCodigo and (t.opetitValor - coalesce(t.opetitDesconto, 0)) = e.ValorNominal)
	  join nfCedente c (nolock) on (i.empCodigo = c.empCodigo and i.cedCodigo = c.cedCodigo and e.OriginadorCnpjCpf = c.pesCNPJCPF)
	  join nfSacado s (nolock) on (i.empCodigo = s.empCodigo and i.sacCodigo = s.sacCodigo and e.SacadoCnpjCpf = s.pesCNPJCPF)
	where
	  e.TipoTitulo = 0
      and e.empCodigo = %0:d
	  and e.ingCodigo is null
      and i.ingCodigoParcial is null
	group by c.pesCNPJCPF, i.ingDocumento
	having count(*) = 1);