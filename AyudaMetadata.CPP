
#include <iostream>
#include <conio.h>
#include <stdio.h> 
#include <string> 
#include <memory.h> 
#include <string.h> 
#include <stdlib.h> 

using namespace std ;

typedef struct TMetadata
{
	int codigo;
    char descripcion[20];
    char tipo[2];
    int longitud;
} TMetadata;

int hashing(int);
void generarVacio(char[],int);
void leerArchivo(char[],int);
void alta(char[], TMetadata metadata[], char [],int);

int ExisteArchivoMetadata(void);
void CompletarCampo(char campo[], TMetadata metadata[],int i,int len);
int leerMetadata( TMetadata metadata[]);
void DameKey(TMetadata metadata[] , char registro[],char newkey[],int );

int main(void)
{
	TMetadata metadata[10];  
	int RegLongitud ;
	cout << "---------------Metadata-----------------" << endl ;
	if (!ExisteArchivoMetadata())
	   {
	    cout << " No existe Archivo de Metadata" << endl ;
	    return 0 ;
       }
    RegLongitud = leerMetadata(metadata );
    cout << "----------------------------------------" << endl << endl ;
	int op;
    char nomArch[20];
    strcpy(nomArch,"Datos.dat");
	do
   {
	  cout<< endl << "ABM Archivo de Datos"<<endl << endl;
	  cout<<"1 - Generar archivo nuevo"<<endl;
      cout<<"2 - Mostrar archivo"<<endl;
      cout<<"3 - Alta"<<endl;
      cout<<"7 - Salir"<<endl;
      cin>>op;
      switch(op)
      {
      	case 1:
            generarVacio(nomArch,RegLongitud);
            break;
         case 2:
          	leerArchivo(nomArch,RegLongitud);
            break;
         case 3:
         	{
             	char registro[RegLongitud] ; memset(registro,0,RegLongitud) ;
            	char campo[64]             ; memset(campo,0,64) ;
         	    for (int i = 0 ; metadata[i].codigo != 0 ; i++ )
             	{
   			      cout << "Ingrese " << metadata[i].descripcion << " " ;  
   			      cin >> campo;
   			      CompletarCampo(campo,metadata,i,strlen(campo));
   			      strcat(registro,campo); 
                }
            strcat(registro,"0000"); //enlace
            alta(nomArch,metadata, registro,RegLongitud);
            break;
            }
         case 4:
         	break;
         case 5:
         	break;
         case 6:
         	break;
      }
   }
   while(op < 7 );
   return 0 ;
}

int leerMetadata(TMetadata metadata[10])
{
	int RegLongitud = 0 ;
	int i = 0 ;
    TMetadata RegMetadata;
	FILE * archivo = fopen("Metadata.dat","r");
	int nb ;
    if(archivo!=NULL)
    {
      nb = fread(&RegMetadata,sizeof(TMetadata),1,archivo);
      cout<<"Numero     Nombre                tipo        longitud" <<endl;
	  while(nb != 0 )
   	  {	
      	if(RegMetadata.codigo!=0)
         {
      		metadata[i].codigo = RegMetadata.codigo;
      		strcpy(metadata[i].descripcion,RegMetadata.descripcion);
      		strcpy(metadata[i].tipo,RegMetadata.tipo) ;
      		metadata[i].longitud = RegMetadata.longitud ;
      		
            cout<<metadata[i].codigo << "         "  << metadata[i].descripcion  << "             " << metadata[i].tipo << "           " << metadata[i].longitud <<endl;
       		RegLongitud += metadata[i].longitud ;
			i++;
		 }
         nb = fread(&RegMetadata,sizeof(TMetadata),1,archivo);
      }
      metadata[i].codigo = 0 ;
      fclose(archivo);
   }
   return RegLongitud ;
}

int hashing(int clave)
{
	return clave % 10;
}

void generarVacio(char nomArch[], int RegLongitud)
{
	cout << "RegLongitud " << RegLongitud << endl ;
	char datos[RegLongitud];
	memset(datos, '.', RegLongitud );  
	datos[RegLongitud]='\0';
	FILE * archivo = fopen(nomArch,"w");
    if(archivo != NULL)
    {
   	    for(int i=0; i<10; i++)
   	    {
   	    	//printf("%d ",fwrite(datos,(long)RegLongitud,1,archivo));
            fwrite(datos,(long)RegLongitud,1,archivo);
   	    }
        fclose(archivo);
   }
}

void leerArchivo(char nomArch[],int RegLongitud)
{
	char datos[RegLongitud];
	FILE * archivo = fopen(nomArch,"r");
	int nb ;
	int pos = 0 ;
    if(archivo != NULL)
    { 
      nb = fread(datos,RegLongitud,1,archivo);
      while(nb != 0 )
   	  {
    	 cout<<"Registro "<< pos << " " << datos <<endl;
         nb = fread(datos,RegLongitud,1,archivo);
         pos++ ;
      }
      fclose(archivo);
   }
}

void alta(char * nomArch, TMetadata metadata[],char  registro[],int RegLongitud)
{	
   char registroLeido[RegLongitud]	;
   FILE * archivo;
   int pos;
   archivo = fopen(nomArch,"r+");
   if(archivo != NULL)
   {
   	   char key[metadata[0].longitud];
   	   
	   DameKey(metadata , registro,key,0);
   	   pos = hashing(atoi(key));
        
       fseek(archivo,pos * RegLongitud,0);
       fread(registroLeido,RegLongitud,1,archivo);
       DameKey(metadata , registroLeido,key,0);
   	    
       if (atoi(key) == 0)
       {
       	 fseek(archivo,-(long)RegLongitud,SEEK_CUR);
       	 fwrite(registro,RegLongitud,1,archivo);
         fclose(archivo);
       }
       else
       {
       	  fclose(archivo);
          archivo = fopen(nomArch,"a");
   	      fwrite(registro,RegLongitud,1,archivo);
          fclose(archivo);
       }     
   }
}


void DameCampo(TMetadata * metadata , char * datos , char * campo , int NroCampo)
{	
	int i ;
	int k = metadata[NroCampo].longitud ;
	for( i = 0 ; datos[i] != ':' ; i++)
	    	campo[i] = datos[i];
	campo[i] = '\0';   	   
	if (!strcmp(metadata[NroCampo].tipo,"i\0"))
	{
		int j ;
		char campoaux[10] ={"00000000\0"};
		campoaux[k] = '\0';
	    for(j = i ; j >= 0 ; j--)
	     { 
	     	     campoaux[k--] = campo[j];
		 }   
		 strcpy(campo,campoaux);
	 }
}

void DameOldCampo(TMetadata * metadata , char * datos , char * campo , int NroCampo)
{	
	int i ;
	int k = metadata[NroCampo].longitud ;
	for( i = 0 ; k-- != 0 ; i++)
	  {
	    	campo[i] = datos[i];
	  //  	cout << " campo --->  i ----> " << i << " " << campo << endl   ;
      }
	campo[i] = '\0';   	   
}


void DameElRestoDelRegistro(TMetadata * metadata,char * newdatos,char * restoReg,int RegLongitud)
{
	int longitudNewCampo ;
	int  j ,k,t ;
	int longitud ;
	int y = 0 ;
	int NroCampo = 0 ;
	int i = 0 ;
	while ( newdatos[i] != ':' ) i++;
	i++;
	while ( newdatos[i] != '*' )
	{
		longitudNewCampo = 0 ;
	    while (newdatos[i] != ':')
		{
		     restoReg[y] = newdatos[i];
		     y++; i++;
		     longitudNewCampo++;
		}
		restoReg[y]='\0';
		i++;
		NroCampo++;
		longitud = metadata[NroCampo].longitud ;
		if(!strcmp(metadata[NroCampo].tipo,"s\0"))
		{
		   longitud -= 	longitudNewCampo ;
		   while (  longitud-- != 0 )
		     {
		        restoReg[y] = '-';
		        y++;
		     }
		}
		else
		{
			if(!strcmp(metadata[NroCampo].tipo,"i\0"))
			{ 
			   char campoaux[10] ={"00000000\0"};
			   campoaux[longitud] = '\0';
			   char campoaux_aux[10] = {"00000000\0"};
			   int x = 0;
			   while(newdatos[i] != ':')
			   {
			   	  campoaux_aux[x] = newdatos[i];
			   	  x++;
			   	  i++;
			   }
			   campoaux_aux[x]='\0';
			   while (x >= 0)
			   {
			         campoaux[longitud--] = campoaux_aux[x--];
		       }
			   longitud = metadata[NroCampo].longitud ;
			   int p = 0;
			   while ( p < metadata[NroCampo].longitud )
			   {
			   	  restoReg[y] = campoaux[p];
			   	  y++; p++;
			   }
			}
		}
	}
	restoReg[RegLongitud]='\0';
}

void DameKey(TMetadata  metadata [], char  registro[] , char key [], int NroCampo)
{	
    int i ;
	int k = metadata[NroCampo].longitud ;
	for( i = 0 ; k-- != 0 ; i++)
	  {
	    	key[i] = registro[i];
      }
	key[i] = '\0';   	   
}

void  CompletarCampo(char campo[], TMetadata metadata[],int x,int len)
{	        
   			if(!strcmp(metadata[x].tipo,"i\0"))
			{ 	
			    int lenlen = len - 1 ;
			    int longitud = metadata[x].longitud - 1 ;
			    char campocompleto[metadata[x].longitud] ;
				for (int i = longitud ; lenlen >= 0 ; i --)
				{
				     	campocompleto[i] = campo[lenlen];
				     	lenlen-- ;
				} 
				for (int i = 0; i < metadata[x].longitud - len ; i++)
				 {
				 	campocompleto[i] = '0' ; 
				 }
				 strcpy(campo,campocompleto);
	        }
            
            if(!strcmp(metadata[x].tipo,"s\0"))
			{ 	
				int i ;
				for (i = len ; i < metadata[x].longitud ; i ++)
				{
				     	campo[i] = '-';
				} 
				campo[i] = '\0';
	        }
}
  

int ExisteArchivoMetadata(void)
{
	FILE * arch = fopen("metadata.dat","r");
	if (arch == NULL)
	    return 0;
	fclose(arch);    
	return 1;
}
