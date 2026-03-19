% revision 1.00.1 beta, 07/01/04

function out = ModFilterBankModel_preproc(in)

global work
global def

%% this is the Dau JASA 1999 modulation filterbank model
fc = work.exppar1;
fs = def.samplerate;
if fc < 10
    Q = fc/5;
elseif fc >= 10
    Q = 2;
end

out = Dau_Model(in,fs,fc,Q);

% eof