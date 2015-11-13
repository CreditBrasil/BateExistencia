unit Core.Metodos;

{ esta biblioteca visa organizar métodos, preferêncialmente
  estáticos, que possuam poucas dependências de outras bibliotecas. }

interface

uses
  System.SysUtils, System.Math, System.Classes, Core.Tipos;

type
  TMetodos = class(TObject)
  public
    class procedure AdicionaLinha(var AStrings: TStringArray; const ALinha: string); overload;
    class procedure AdicionaLinha(var AStrings: TStringArray; const ALinhas: TStringArray); overload;
    class function Arredonda(Valor: Double; Decimais: Integer): Double;
    class function ArredondaCurr(const Valor: Currency; Decimais: Integer): Currency;
    class function CalculaDigitoVerificadorCnpjCpf(const ACnpjCpfSemDigito: string; ACpf: Boolean): string;
    class function CharSetToString(const CharSet: TCharSet; const Delimitador: string = '';
      const Separador: string = ','): string;
    class function ChecaDigitoVerificadorCnpjCpf(const ACnpjCpf: string): Boolean;
    class function ColocaPontos(const CGC: string; ComTexto: Boolean = False): string;
    class function Dinheiro(const Valor: Extended): Extended;
    class function DinheiroCurr(const Valor: Currency): Currency;
    class function DinheiroTruncado(const Valor: Extended): Extended;
    class function EstaNaLista(I: Integer; const A: array of Integer): Boolean;
    class function LimpaString(const ALinha, ACaracteres: string; const ASubistiuir: string = ' '): string;
    class function Linhas(const AStrings: TStringArray): string;
    class function Numerico(const ANumero: string): Boolean;
    class function PoeLetra(const Entrada: string; Qtd: Integer; Letra: Char = ' '): String;
    class function PoeLetraEsq(const Entrada: string; Qtd: Integer; Letra: Char = ' '): string;
    class procedure QuickSort(var A: TValores);
    class function RetirarAcentos(const Entrada: string): string;
    class function RetirarEspacosRepetidos(const AEntrada: string): string;
    class function SoLetra(const Entrada: string): string;
    class function SoNumero(const Entrada: string): string;
    { (Edgar 06/03/2006) os elementos do array-parâmetro devem ser ordernados
      pelo código que precede a string descritiva. }
    class function StringPorCodigo(const Codigo: Integer; const Strings: array of string; const TamanhoCodigo: Integer;
      const Padrao: string): string; overload;
    class function StringPorCodigo(const Codigo: string; const Strings: array of string; const TamanhoCodigo: Integer;
      const Padrao: string): string; overload;
    class function StringPorCodigo(const Codigo: Integer; const Strings: array of string; const TamanhoCodigo: Integer)
      : string; overload;
    class function StringPorCodigo(const Codigo: string; const Strings: array of string; const TamanhoCodigo: Integer)
      : string; overload;
    class function StrToDateDef(const Str: string; const Def: Double): Double;
    class function StrToFloatDef(const Str: string; const Def: Double): Double;
    class function StrToPChar(const AValor: string): PChar;
    class function TrocaCaracteres(Entrada: string): string;
    class function Trunca(const Valor: Extended; Decimais: Integer): Extended;
    class function SoLetraNumero(const Entrada: string): string;
  end;

implementation

{ TMetodos }

class procedure TMetodos.AdicionaLinha(var AStrings: TStringArray; const ALinha: string);
begin
  SetLength(AStrings, Length(AStrings) + 1);
  AStrings[Length(AStrings) - 1] := ALinha;
end;

class procedure TMetodos.AdicionaLinha(var AStrings: TStringArray; const ALinhas: TStringArray);
var
  laco: Integer;
begin
  for laco := Low(ALinhas) to High(ALinhas) do
    AdicionaLinha(AStrings, ALinhas[laco]);
end;

class function TMetodos.Arredonda(Valor: Double; Decimais: Integer): Double;
{ Alex - 30/09/2014
  Com o valor de título 2.161,00 e % de ad valorem de 0,5 no XP tinhamos 10,81 e no Windows 7 tinhamos 10,80 de ad valorem.
  Percebi que isso era problema com arredondamento... funçando na internet achei esta página:
  http://qc.embarcadero.com/wc/qcmain.aspx?d=103460
  Que sugere a gambiarra abaixo, ela funcionou!!! :-)
  Vou manter o código anterior para futuros debugs

  var
  casas: Double;
  sinal: Integer;
  begin
  if Valor >= 0 then
  sinal := 1
  else
  sinal := -1;
  casas := IntPower(10, Decimais);
  Result := Int(Abs(Valor) * casas + 0.5) / casas * sinal;
  end;
}
var
  LFactor: Extended;
  D: Double;
  I: Int64;
  AFactor: Double;
begin
  LFactor := IntPower(10, -Decimais);
  if Valor < 0 then
    AFactor := -0.5
  else
    AFactor := 0.5;

  D := (Valor / LFactor) + AFactor;
  I := Trunc(D);

  Result := I * LFactor;
end;

class function TMetodos.ArredondaCurr(const Valor: Currency; Decimais: Integer): Currency;
begin
  Result := Arredonda(Valor, Decimais);
end;

class function TMetodos.CalculaDigitoVerificadorCnpjCpf(
  const ACnpjCpfSemDigito: string; ACpf: Boolean): string;
var
  S1, S2: Integer;
  V, I, M1, M2: Integer;
  L: string;
  D1, D2: Integer;
begin
  //Alex - 10/07/2010 - Cópia da função CGCCPFDV da mFunctions
  Result := '00';
  S1 := 0;
  S2 := 0;
  M2 := 2;
  for I := Length(ACnpjCpfSemDigito) downto 1 do
  begin
    L := Copy(ACnpjCpfSemDigito, I, 1);
    if StrToInt(L) in [0..9] then
    begin
      M1 := M2;
      if ACpf or (M2 < 9) then
        M2 := M2 + 1
      else
        M2 := 2;
      V := StrToInt(L);
      S1 := S1 + (V * M1);
      S2 := S2 + (V * M2);
    end;
  end;
  S1 := S1 mod 11;
  if S1 < 2 then
    D1 := 0
  else
    D1 := 11 - S1;
  S2 := (S2 + 2 * D1) mod 11;
  if S2 < 2 then
    D2 := 0
  else
    D2 := 11 - S2;
  Result := IntToStr(D1) + IntToStr(D2);
end;

class function TMetodos.CharSetToString(const CharSet: TCharSet; const Delimitador, Separador: string): string;
var
  laco: Char;
begin
  Result := '';
  if CharSet = [] then
    Exit;
  for laco := Low(Char) to High(Char) do
    if CharInSet(laco, CharSet) then
      Result := Result + Delimitador + laco + Delimitador + Separador;
  Delete(Result, Length(Result) - Length(Separador) + 1, Length(Separador));
end;

class function TMetodos.ChecaDigitoVerificadorCnpjCpf(
  const ACnpjCpf: string): Boolean;
var
  LSoNumero: string;
  LDigitoVerificadorInformado: string;
  LTamanho: Integer;
begin
  LSoNumero := SoNumero(ACnpjCpf);
  LDigitoVerificadorInformado := Copy(LSoNumero, Length(LSoNumero) - 1, 2);
  LSoNumero := Copy(LSoNumero, 1, Length(LSoNumero) - 2);
  LTamanho := Length(LSoNumero);
  if LTamanho = 9 then
    Result := LDigitoVerificadorInformado = CalculaDigitoVerificadorCnpjCpf(LSoNumero, True)
  else if (LTamanho = 12) or (LTamanho = 13) then
    Result := LDigitoVerificadorInformado = CalculaDigitoVerificadorCnpjCpf(LSoNumero, False)
  else
    Result := False;
end;

class function TMetodos.ColocaPontos(const CGC: string;
  ComTexto: Boolean): string;
var
  laco: integer;
  dv, nr, texto: string;
begin
  Result := CGC;
  // retirar todos os (.,/-)
  nr := '';
  texto := '';
  for laco := 1 to length( CGC ) do
  begin
    if CharInSet(CGC[laco], [ '0'..'9' ]) then
    begin
      nr := nr + CGC[laco];
      texto := '';
    end;
    if CharInSet(UpCase(CGC[laco]), ['A'..'Z']) then
      texto := texto + UpCase(CGC[laco]);
  end;
  dv := copy( nr, length( nr ) - 1, 2 );
  nr := copy( nr, 1, length( nr ) - 2 );
  if length( nr ) = 9 then
  begin
    if dv = CalculaDigitoVerificadorCnpjCpf(nr, True) then
      Result := Copy(nr, 1, 3) + '.' + Copy(nr, 4, 3) + '.' + Copy(nr, 7, 3)
                + '-' + dv;
    if ComTexto and (texto <> '') then
      Result := Result + texto;
  end;
  if length( nr ) = 12 then
    if dv = CalculaDigitoVerificadorCnpjCpf(nr, False) then
      Result := Copy(nr, 1, 2) + '.' + Copy(nr, 3, 3) + '.' + Copy(nr, 6, 3)
                + '/' + Copy(nr, 9, 4) + '-' + dv;
  if length( nr ) = 13 then
  begin
    if dv = CalculaDigitoVerificadorCnpjCpf(nr, False) then
      Result := Copy(nr, 1, 3) + '.' + Copy(nr, 4, 3) + '.' + Copy(nr, 7, 3)
                + '/' + Copy(nr, 10, 4) + '-' + dv;
    if Result[1] = '0' then
      Delete(Result, 1, 1);
  end;
end;

class function TMetodos.Dinheiro(const Valor: Extended): Extended;
begin
  Result := Arredonda(Valor, 2);
end;

class function TMetodos.DinheiroCurr(const Valor: Currency): Currency;
begin
  Result := ArredondaCurr(Valor, 2);
end;

class function TMetodos.DinheiroTruncado(const Valor: Extended): Extended;
begin
  Result := Trunca(Valor, 2);
end;

class function TMetodos.EstaNaLista(I: Integer; const A: array of Integer): Boolean;
var
  laco: Integer;
begin
  Result := False;
  for laco := Low(A) to High(A) do
    if (A[laco] = I) then
    begin
      Result := True;
      Break;
    end;
end;

class function TMetodos.LimpaString(const ALinha, ACaracteres: string; const ASubistiuir: string): string;
var
  LCaracteres: TStrings;
  laco: Integer;
begin
  Result := ALinha;
  LCaracteres := TStringList.Create;
  try
    LCaracteres.CommaText := ACaracteres;
    for laco := 0 to LCaracteres.Count - 1 do
      Result := StringReplace(Result, LCaracteres.Strings[laco], ASubistiuir, [rfReplaceAll]);
  finally
    LCaracteres.Free;
  end;
end;

class function TMetodos.Linhas(const AStrings: TStringArray): string;
var
  laco: Integer;
begin
  Result := AStrings[Low(AStrings)];
  for laco := Low(AStrings) + 1 to High(AStrings) do
    Result := Result + #13#10 + AStrings[laco];
end;

class function TMetodos.Numerico(const ANumero: string): Boolean;
var
  laco: Integer;
  LChar: Char;
begin
  Result := False;
  for laco := 1 to Length(ANumero) do
  begin
    LChar := ANumero[laco];
    Result := CharInSet(LChar, ['0' .. '9']);
    if not Result then
      Break;
  end;
end;

class function TMetodos.PoeLetra(const Entrada: string; Qtd: Integer; Letra: Char): String;
var
  Tamanho: Integer;
begin
  Tamanho := Length(Entrada);
  if Tamanho >= Qtd then
    Result := Copy(Entrada, 1, Qtd)
  else
    Result := Entrada + StringOfChar(Letra, Qtd - Tamanho);
end;

class function TMetodos.PoeLetraEsq(const Entrada: string; Qtd: Integer; Letra: Char): string;
begin
  Result := Copy(StringOfChar(Letra, Qtd) + Entrada, Length(Entrada) + 1, Qtd);
end;

class procedure TMetodos.QuickSort(var A: TValores);

  procedure Sort(var A: TValores; iLo, iHi: Integer);
  var
    Lo, Hi: Integer;
    Mid: Double;
    T: TValor;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := A[(Lo + Hi) div 2].Valor;
    repeat
      while A[Lo].Valor < Mid do
        Inc(Lo);
      while A[Hi].Valor > Mid do
        Dec(Hi);
      if Lo <= Hi then
      begin
        T := A[Lo];
        A[Lo] := A[Hi];
        A[Hi] := T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then
      Sort(A, iLo, Hi);
    if Lo < iHi then
      Sort(A, Lo, iHi);
  end;

begin
  if Length(A) > 0 then
    Sort(A, Low(A), High(A));
end;

class function TMetodos.RetirarAcentos(const Entrada: string): string;
const
  LAcentos = 'áéíóúäëïöüâêîôûãõàèìòùÁÉÍÓÚÄËÏÖÜÂÊÎÔÛÃÕÀÈÌÒÙÇç';
  LSemAcentos = 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOUCc';
var
  laco: Integer;
begin
  Result := '';
  for laco := 1 to Length(Entrada) do
    if Pos(Entrada[laco], LAcentos) > 0 then
      Result := Result + LSemAcentos[Pos(Entrada[laco], LAcentos)]
    else
      Result := Result + Entrada[laco];
end;

class function TMetodos.RetirarEspacosRepetidos(const AEntrada: string): string;
var
  LSaida: string;
  LEspaco: Boolean;
  laco: Integer;
begin
  LEspaco := False;
  LSaida := '';
  for laco := 1 to Length(AEntrada) do
  begin
    if LEspaco then
    begin
      if AEntrada[laco] <> ' ' then
      begin
        LEspaco := False;
        LSaida := LSaida + AEntrada[laco];
      end;
    end
    else
    begin
      if AEntrada[laco] = ' ' then
        LEspaco := True;
      LSaida := LSaida + AEntrada[laco];
    end;
  end;
  Result := LSaida;
end;

class function TMetodos.SoLetra(const Entrada: string): string;
var
  laco: Integer;
begin
  Result := '';
  for laco := 1 to Length(Entrada) do
    if CharInSet(UpCase(Entrada[laco]), ['A' .. 'Z']) then
      Result := Result + UpCase(Entrada[laco]);
end;

class function TMetodos.SoLetraNumero(const Entrada: string): string;
var
  laco: Integer;
begin
  Result := '';
  for laco := 1 to Length(Entrada) do
    if CharInSet(UpCase(Entrada[laco]), ['A' .. 'Z', '0' .. '9']) then
      Result := Result + UpCase(Entrada[laco]);
end;

class function TMetodos.SoNumero(const Entrada: string): string;
var
  laco: Integer;
begin
  Result := '';
  for laco := 1 to Length(Entrada) do
    if CharInSet(Entrada[laco], ['0' .. '9']) then
      Result := Result + Entrada[laco];
end;

class function TMetodos.StringPorCodigo(const Codigo: Integer; const Strings: array of string;
  const TamanhoCodigo: Integer; const Padrao: string): string;
var
  aux: string;
begin
  aux := PoeLetraEsq(IntToStr(Codigo), TamanhoCodigo, '0');
  Result := StringPorCodigo(aux, Strings, TamanhoCodigo, Padrao);
end;

class function TMetodos.StringPorCodigo(const Codigo: string; const Strings: array of string;
  const TamanhoCodigo: Integer; const Padrao: string): string;
var
  laco: Integer;
  aux: string;
begin
  Result := Padrao;
  for laco := 0 to Length(Strings) - 1 do
  begin
    aux := Copy(Strings[laco], 1, TamanhoCodigo);
    if Codigo = aux then
    begin
      Result := Copy(Strings[laco], TamanhoCodigo + 1, Length(Strings[laco]) - 1);
      Break;
    end
    else if Codigo < aux then
      Break;
  end;
end;

class function TMetodos.StringPorCodigo(const Codigo: Integer; const Strings: array of string;
  const TamanhoCodigo: Integer): string;
begin
  Result := StringPorCodigo(Codigo, Strings, TamanhoCodigo, '');
end;

class function TMetodos.StringPorCodigo(const Codigo: string; const Strings: array of string;
  const TamanhoCodigo: Integer): string;
begin
  Result := StringPorCodigo(Codigo, Strings, TamanhoCodigo, '');
end;

class function TMetodos.StrToDateDef(const Str: string; const Def: Double): Double;
begin
  try
    Result := StrToDate(Str);
  except
    Result := Def;
  end;
end;

class function TMetodos.StrToFloatDef(const Str: string; const Def: Double): Double;
begin
  try
    Result := StrToFloat(Str);
  except
    Result := Def;
  end;
end;

class function TMetodos.StrToPChar(const AValor: string): PChar;
begin
  GetMem(Result, Length(AValor) + 1);
  StrPCopy(Result, AValor);
end;

class function TMetodos.TrocaCaracteres(Entrada: string): string;
const
  DirtyUnicode: array [0 .. 42] of Char = 'Æµ …ƒˆÖ¡åä¢“š£€‡Ó';
  CleanChar: array [0 .. 42] of Char = 'an  fE OiaacoUuLEcO';
var
  I: Integer;
  n: Integer;
begin
  for I := 1 to Length(Entrada) do
  begin
    n := Pos(Entrada[I], DirtyUnicode);
    if n > 0 then
      Entrada[I] := CleanChar[n - 1];
  end;
  Result := RetirarAcentos(Entrada);
end;

class function TMetodos.Trunca(const Valor: Extended; Decimais: Integer): Extended;
var
  casas: Double;
  sinal: Integer;
begin
  if Valor >= 0 then
    sinal := 1
  else
    sinal := -1;
  casas := IntPower(10, Decimais);
  Result := Int(Abs(Valor) * casas) / casas * sinal;
end;

end.
