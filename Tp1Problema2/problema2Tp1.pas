unit problema2Tp1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

const
minTabla=1;       //Inicio del archivo
MaxTabla=200;     //Final del archivo, le agrego un poco mas para la listaDeCoalición
                  //En este caso lo hice chico al tamaño para comprobar la ubicacion de los archivos
type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Button2: TButton;
    Edit1: TEdit;
    Button4: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);

    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;



  tRegistro=record           //Registro
  idCliente:Integer;
  nombre:String[20];
  apellido:String[20];
  sw:boolean;
  end;



var
  Form1: TForm1;
  rReg: File of tRegistro;

implementation

{$R *.dfm}

   {.Desarrolle un nuevo programa para el manejo de esta lista de clientes,
     teniendo en cuenta que el campo Cliente es la clave primaria del archivo.
     Utilice un algoritmo de hashing apropiado para su implementación.
     Se supone que no hay más de 700 clientes.
   }


{Inicializo el archivo con los registros vacios, asi le doy un tamaño al archivo}
procedure inicializar();
  var i:integer;
      rArc:tRegistro;
   begin
    rewrite(rReg);
    Seek(rReg,minTabla);
      for i:= minTabla to MaxTabla do begin
          rArc.idCliente:=-1;    {Creo la clave cliente en -1, para saber que es registro vacio}
          rArc.nombre:='';
          rArc.apellido:='';
          rArc.sw:=False;
          Write(rReg,rArc);
      end;
    Close(rReg);
   end;



{Tranformacion de la clave por hash, ustedes pueden buscar otras,
 se tendria que buscar una tranformacion que permita una buena performace del programa,
 en pocas palabras que no sea ineficiente(que no haya muchas coalisiones)}
Function hashCode(pk:integer):Integer;
 begin
   hashCode:= round(pk mod 199); {Mayormente se usan numeros primos, mas cercano a la cantidad de archivos}
 end;


{Se agrega un registro, si el idCliente al hacerle el hash tiene la posicion ocupada en
 el archivo,se posicionara en la parte de zona de colisiones, si se quiere
 buscar en esa zona se debera recorrer secuencialmente}
procedure agregarRegistro(rR:tRegistro;m:TMemo);
    var rArc:tRegistro;
        pk,Q:Integer;  {pk es el codigo hash, que se nos da cuando usamos el procedimiento de "HashCode"}
        Flag:Boolean;
     begin
         pk:=hashCode(rR.idCliente); {Creo HashCode}
         reset(rReg);
         Seek(rReg,pk); {Lo posiciono en ese lugar en el archivo}
         read(rReg,rArc); {Lo leo para saber que tiene ese registro}
           if (rArc.idCliente = -1) then  begin {Si es -1 entonces se agrega en el archivo}
             Seek(rReg,pk);{Lo tengo que posicionar,porque el read, me apunta al siguente}
             Write(rReg,rR);
           end
           else begin   {se agrega un registro en una posicion vacia}
             Flag:=False;{bandera para que salga del while}
             Q:=MaxTabla-49;{Posiciono en la zona de coalisiones(despues tengo que buscar el pocentaje que deberia tener)}
             Seek(rReg,Q);
               while (not(flag)) do begin
                    read(rReg,rArc);
                     if (rArc.idCliente = -1) then begin  {Mismo idea que el if anterior}
                         Seek(rReg,Q);
                         Flag:=True;
                         Write(rReg,rR);
                     end else begin
                         inc(Q);       {si llegara estar ocupada la posicion}
                         Seek(rReg,Q); {se incrementa Q y se posiciona con el Seek al siguente}
                     end;
               end;
           end;
     CloseFile(rReg);
     end;


Procedure buscarRegistro(id:integer;m:TMemo);
 var  aRc:tRegistro;
      pk,Q:integer;
      flag:boolean;
  begin
     m.Clear;
     reset(rReg);
     pk:=hashCode(id);
     Seek(rReg,pk);
     read(rReg,aRc);
        if (aRc.idCliente = id ) then begin       {Busca el registro por Hash}
           m.Lines.Add(aRc.idCliente.ToString);
           m.Lines.Add(aRc.nombre);
           m.Lines.Add(aRc.apellido);
        end
        else begin  {Sino lo encuentra hace un busqueda secuencial,en la zona de colisiones }
           Flag:=False;{bandera para que salga del while}
           Q:=MaxTabla-51;{Posiciono en la zona de coalisiones}
           Seek(rReg,Q);
               while (not(flag)) and (not (eof(rReg))) do begin
                    read(rReg,aRc);
                     if (aRc.idCliente = id) then begin  {Mismo idea que el if anterior}
                         m.Lines.Add(aRc.idCliente.ToString);
                         m.Lines.Add(aRc.nombre);
                         m.Lines.Add(aRc.apellido);
                         flag:=True;
                     end else begin
                         inc(Q);       {si llegara estar ocopada la posicion}
                         Seek(rReg,Q); {se incrementa Q y se posiciona con el Seek}
                     end;
               end;
                if flag = false then
                     ShowMessage('El Registro "No existe"'); {mando un mesaje de que recorrio todo y no lo encontro}
        end;

     Close(rReg);
  end;



procedure TForm1.Button1Click(Sender: TObject);
var aArc:tRegistro;
    ac:integer;
begin           {Este boton solo lo hice para ver todos los registros, recorrido secuencial}
memo1.Clear;
ac:=1;
    reset(rReg);
    Seek(rReg,minTabla);
     while (not eof(rReg)) do begin
       read(rReg,aArc);
        if (aArc.idCliente <> -1) then begin
          memo1.Lines.Add('//////REGISTRO' + ac.ToString +'/////////////');
          memo1.Lines.Add(aArc.idCliente.ToString);
          memo1.Lines.Add(aArc.nombre);
          memo1.Lines.Add(aArc.apellido);
        end;
        inc(ac);
     end;
     CloseFile(rReg);
end;

procedure TForm1.Button2Click(Sender: TObject);
     var rRegistro:tRegistro;
         Flag:String;
        begin
        {Si quieren, en el while le pueden agregar una condicion, a la cual no permita crear
         un nuevo registro si supera la cantidad de posiciones establecidas en la inicializacion}
             while (flag <> 'N' ) do begin
               rRegistro.nombre:=(InputBox('Ingrese su nombre','Nombre',''));
               rRegistro.apellido:=(InputBox('Ingrese su Apellido','Apellido',''));
               rRegistro.idCliente:=StrToint(InputBox('Ingrese su Nro Cliente','Cliente',''));
                   while ((rRegistro.idCliente < 1000) or (rRegistro.idCliente > 9999)) do {Condicion para que el numero de cliente sea de 4Digitos}
                      rRegistro.idCliente:=StrToint(InputBox('ERROR','Cliente (Cuatro digitos)',''));
               rRegistro.sw:=true;
               agregarRegistro(rRegistro,Memo1);{Lo lleva al procediminto para agregar el registro}

               Flag:=UpperCase(InputBox('Continuar','Quiere seguir S/N',''));
                 while (flag<>'N') and (flag<>'S') do
                  flag:=UpperCase(InputBox('Continuar','Quiere seguir S/N',''));

             end;

        end;

 procedure TForm1.Button3Click(Sender: TObject);
 begin
   Application.Terminate;
 end;

procedure TForm1.Button4Click(Sender: TObject);
var id:Integer;
begin
  id:=StrToInt(edit1.Text);
      while ((id < 1000) or (id > 9999)) do {Condicion para que el numero de cliente sea de 4Digitos}
         id:=StrToint(InputBox('ERROR','Cliente (Cuatro digitos)',''));
         buscarRegistro(id,Memo1); {Le paso el codigo del cliente, que se encuentra en el edit1
                                    Pueden si quieren orientarse mejor hacer una variable}
end;

procedure TForm1.FormCreate(Sender: TObject);
  begin
  memo1.Clear;
    if(FileExists('Clientes.txt')) then begin {Se fija en el win32(debbug) si esta el archivo}
       AssignFile(rReg,'Clientes.txt'); {si esta lo asigna}
    end
    else begin
       AssignFile(rReg,'Clientes.txt');
       inicializar;     {Si no existe, lo asigna y lo inicializa }
    end;

  end;



end.
