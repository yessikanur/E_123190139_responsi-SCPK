function varargout = SAW123190139(varargin)
% SAW123190139 MATLAB code for SAW123190139.fig
%      SAW123190139, by itself, creates a new SAW123190139 or raises the existing
%      singleton*.
%
%      H = SAW123190139 returns the handle to a new SAW123190139 or the handle to
%      the existing singleton*.
%
%      SAW123190139('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW123190139.M with the given input arguments.
%
%      SAW123190139('Property','Value',...) creates a new SAW123190139 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW123190139_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW123190139_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW123190139

% Last Modified by GUIDE v2.5 26-Jun-2021 12:13:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW123190139_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW123190139_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SAW123190139 is made visible.
function SAW123190139_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW123190139 (see VARARGIN)

% Choose default command line output for SAW123190139
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW123190139 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW123190139_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%mengambil seluruh data yang ada pada kolom 1 (Nomor Rumah
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (1);
kolom1 = readmatrix('DATA RUMAH.xlsx',opts);

%mengambil seluruh data yang ada pada kolom 3 sampai 8 (Harga - Garasi)
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (3:8);
kolom38 = readmatrix('DATA RUMAH.xlsx',opts);

%menggabungkan data pada kolom1 dan kolom38 menjadi satu matrix
data = [kolom1 kolom38];
set(handles.uitable1,'data',data);%mengeluarkan data var'data' pada tabel1

%mengambil seluruh data yang ada pada kolom 3 sampai 8 (Harga - Garasi)
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (3:8);
dataProses = readmatrix('DATA RUMAH.xlsx',opts);
k=[0,1,1,1,1,1];%kriteria, yaitu 1=atribut benefit, dan  0= atribut cost
%w = Nilai bobot tiap untuk setiap kriteria -> ditentukan berdasarkan soal
w=[0.30,0.20,0.23,0.10,0.07,0.10];

%tahapan 1. normalisasi matriks
[m n]=size (dataProses); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=dataProses(:,j)./max(dataProses(:,j));
    else
        R(:,j)=min(dataProses(:,j))./dataProses(:,j);
    end;
end;

%tahapan kedua, proses perangkingan
for i=1:m,
 V(i)= sum(w.*R(i,:));
end;

Vt=V.';%transpose matrix V
Vt=num2cell(Vt);%mengumpulkan baris atau kolom ke dalam sel 
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (2);%mengambil kolom dua (alamat rumah) untuk perankingan
dataFix= readtable('DATA RUMAH.xlsx',opts);
dataFix = table2cell(dataFix);
dataFix=[dataFix Vt];
dataFix=sortrows(dataFix,-2);%dilakukan perankingan
disp(dataFix)
dataFix = dataFix(1:20,1);%mengambil 20 baris (20 data) dan seluruh kolom (kolom alamat rumah)

set(handles.uitable2, 'data', dataFix);%menampilkan dataFix kedalam uitable2
