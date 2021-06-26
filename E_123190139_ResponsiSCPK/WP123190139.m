data = xlsread('Real Estate valuation data set.xlsx', 'C2:E51');
data1 = xlsread('Real Estate valuation data set.xlsx', 'H2:H51'); %membaca file
x = [data data1];
k = [1,0,1,0]; %jenis kriteria 1 : keuntungan, 0 : biaya
w = [3,5,4,1]; %nilai bobot kriteria

[m n]=size (x); %inisialisasi ukuran x 
w = w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot


for j=1:n, 
    if k(j)==0, 
        w(j)=-1*w(j); 
    end; 
end; 
for i=1:m, 
    P(i)=prod(x(i,:).^w); 
end;


V= P/sum(P)
B = sort(V, 'descend'); %sorting dari terbesar
opts = detectImportOptions('Real Estate valuation data set.xlsx');
opts.SelectedVariableNames = (1);
rekomendasi = readmatrix('Real Estate valuation data set.xlsx', opts); %membaca file Real Estate.xlsx

for i=1:5 %mengambil data peringkat 1 sampai 5
    for j=1:m
      if(B(i) == V(j))
          hasil(i) = "no " + rekomendasi(j);
          break;
        end
    end
end

hasil