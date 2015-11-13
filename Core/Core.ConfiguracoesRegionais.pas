unit Core.ConfiguracoesRegionais;

interface

uses
  System.SysUtils;

type
  TConfiguracoesRegionais = class(TObject)
  public
    class procedure FixarBrasil;
  end;

implementation

{ TConfiguracoesRegionais }

class procedure TConfiguracoesRegionais.FixarBrasil;
begin
  FormatSettings.CurrencyString := 'R$ ';
  FormatSettings.CurrencyFormat := 0; //$1
  FormatSettings.NegCurrFormat := 0; //($1)
  FormatSettings.ThousandSeparator := '.';
  FormatSettings.DecimalSeparator := ',';
  FormatSettings.CurrencyDecimals := 2;
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'DD/MM/YYYY';
  FormatSettings.LongDateFormat := 'DDDD, D" de "MMMM" de "YYYY';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.TimeAMString := 'am';
  FormatSettings.TimePMString := 'pm';
  FormatSettings.ShortTimeFormat := 'hh:mm';
  FormatSettings.LongTimeFormat :=   FormatSettings.ShortTimeFormat + ':ss';
  FormatSettings.ShortMonthNames[1] := 'jan';
  FormatSettings.ShortMonthNames[2] := 'fev';
  FormatSettings.ShortMonthNames[3] := 'mar';
  FormatSettings.ShortMonthNames[4] := 'abr';
  FormatSettings.ShortMonthNames[5] := 'mai';
  FormatSettings.ShortMonthNames[6] := 'jun';
  FormatSettings.ShortMonthNames[7] := 'jul';
  FormatSettings.ShortMonthNames[8] := 'ago';
  FormatSettings.ShortMonthNames[9] := 'set';
  FormatSettings.ShortMonthNames[10] := 'out';
  FormatSettings.ShortMonthNames[11] := 'nov';
  FormatSettings.ShortMonthNames[12] := 'dez';
  FormatSettings.LongMonthNames[1] := 'janeiro';
  FormatSettings.LongMonthNames[2] := 'fevereiro';
  FormatSettings.LongMonthNames[3] := 'março';
  FormatSettings.LongMonthNames[4] := 'abril';
  FormatSettings.LongMonthNames[5] := 'maio';
  FormatSettings.LongMonthNames[6] := 'junho';
  FormatSettings.LongMonthNames[7] := 'julho';
  FormatSettings.LongMonthNames[8] := 'agosto';
  FormatSettings.LongMonthNames[9] := 'setembro';
  FormatSettings.LongMonthNames[10] := 'outubro';
  FormatSettings.LongMonthNames[11] := 'novembro';
  FormatSettings.LongMonthNames[12] := 'dezembro';
  FormatSettings.ShortDayNames[1] := 'dom';
  FormatSettings.ShortDayNames[2] := 'seg';
  FormatSettings.ShortDayNames[3] := 'ter';
  FormatSettings.ShortDayNames[4] := 'qua';
  FormatSettings.ShortDayNames[5] := 'qui';
  FormatSettings.ShortDayNames[6] := 'sex';
  FormatSettings.ShortDayNames[7] := 'sab';
  FormatSettings.LongDayNames[1] := 'domingo';
  FormatSettings.LongDayNames[2] := 'segunda';
  FormatSettings.LongDayNames[3] := 'terça';
  FormatSettings.LongDayNames[4] := 'quarta';
  FormatSettings.LongDayNames[5] := 'quinta';
  FormatSettings.LongDayNames[6] := 'sexta';
  FormatSettings.LongDayNames[7] := 'sábado';

  {SysLocale -> Variavel que eu não ajustei por não achar necessário,
  pode ser que seja necessário mais para frente.}

  {EraNames, EraYearOffsets -> variaveis usadas usadas no oriente,
  não necessárias no Brasil}

  //se ano de dois digitos:
  //50 menos o ano corrente indica a janela de tempo para que se considere
  //próximo século, assim se estivermos em 2005 - 50 = 1955
  //de 55 até 99 considera-se então 1955 até 1999 e
  //de 0 até 54 considera-se de 2000 até 2054
  FormatSettings.TwoDigitYearCenturyWindow := 50;
  FormatSettings.ListSeparator := ';';
end;

end.
