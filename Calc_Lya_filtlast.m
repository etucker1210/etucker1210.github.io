 function [SSlegtheta,SSlegx,SSlegy,Output]= Calc_Lya(data,footfall,timelag)
%%The goal of this function is to:
    %1. import position data (going to start with theta)
    %2. Average strides to ~100 samples, and concatenate
    %3. calculate False nearest neighbors dimension for each individual
    %4. create state spaces for data using the inputted time lag
%data is the current spider structure and timelag should be 10 unless we
%figure out otherwise...
    
   %% this is a test for just one and then will automate.
   %See how many unique spider names there are.
  names = unique({data.ID});
  treatments = unique({data.treat});
  numtrials = size(data,2);
  posX = cell(1,numtrials);
  poslegY=cell(1,numtrials);
  SSlegx = cell(1,numtrials);
  SSlegy = cell(1,numtrials);
  SSlegtheta = cell(1,numtrials);
  %Get footfalls
  FD={footfall.FD};
  %%Filter position data leg
  for i=1:numtrials  
    if ~isempty(data(i).res) 
        for j=1:8
            if sum(~isnan(FD{i}(j,:)))>=2
                index(1) = find(FD{i}(j,:)== min(FD{i}(j,:)));
                if isnan(data(i).res.pthX(FD{i}(j,index(1)),j))
                    index(1) = index+1;
                end
                index(2) = find(FD{i}(j,:)== max(FD{i}(j,:)));
                numstrides = diff(index,1);
                samples = numstrides*100;
                posx = data(i).res.pthX(FD{i}(j,index(1)):FD{i}(j,index(2))-1,j);
                posy = data(i).res.pthY(FD{i}(j,index(1)):FD{i}(j,index(2))-1,j);
                nanpos = find(isnan(posx));
                tempx = posx;
                tempy = posy;
                t = 0:1/500:(size(tempx,1)-1)/500;
                if max(find(nanpos))-min(find(nanpos))~=0     % additional NaN exists
                    rnanpos     =   find(isnan(tempx));
                    Xnan        =   tempx(~isnan(tempx),:);
                    Ynan        =   tempy(~isnan(tempy),:);
                    tnan        =   t(~isnan(tempx));
                else
                    rnanpos     =   [];
                    Xnan        =   tempx;
                    Ynan        =   tempy;
                    tnan        =   t;
                end
                Xnew      =   fnval(t,csaps(tnan,Xnan,1));
                Ynew      =   fnval(t,csaps(tnan,Ynan,1));
%                 % filter data
%                 [xfilt,b,a]=lopass_butterworth(Xnew,30,500,4);
%                 [yfilt,b,a]=lopass_butterworth(Ynew,30,500,4);

                %if not filtering now
                xfilt= Xnew;
                yfilt=Ynew;
                
                poslegX{i}{j} = xfilt;
                poslegY{i}{j} = yfilt;

                %Make new gaitspace timing.
                tnew = (0:samples-1)/samples*length(xfilt)/500;
                sxnorm = fnval(tnew,csaps(t,xfilt));
                synorm = fnval(tnew,csaps(t,yfilt));
                SSlegx{i}{j}(:,1) = sxnorm;
                SSlegy{i}{j}(:,1) = synorm;
                [theta,rho]= cart2pol(sxnorm-nanmean(sxnorm),synorm-nanmean(synorm));
              %theta = theta-nanmean(theta);
                SSlegtheta{i}{j}(:,1) = theta ;
                clear index a b xfilt yfilt temp* *nan* posx posy... 
                theta rho series* *new samples numstrides t
            else
                posX{i}{j} = [];
                poslegY{i}{j} = [];
                SSlegx{i}{j}= [];
                SSlegy{i}{j} = [];
                SSlegtheta{i}{j}= [];
            clear index a b xfilt yfilt temp* *nan* posx posy... 
                theta rho series* *new samples numstrides t sx* sy*
            end
        end
    end
  end
    clear  i j

  %%Concatinate strides together
  %%Preform false nearest neighbor for dimensions.
  count=1;
  for s = 1:length(names)
      spiderindex = find(strcmp({data.ID},names{s}));
      for t = 1:length(treatments)
          loc = find(strcmp({data(spiderindex).treat},treatments{t}))+spiderindex(1)-1;
          if ~isempty(loc)
              serieslegtheta = cell(1,8);
              serieslegx = cell(1,8);
              serieslegy = cell(1,8);
              sFreq = cell(1,8);
              dutyfactor= cell(1,8);
              sLength= cell(1,8);
              sFreqsd = nan(1,9);
              dutyfactorsd = nan(1,9);
              sLengthsd = nan(1,9);
              for j = 1:8
                  for i = 1:length(loc)
                      if ~isempty(SSlegtheta{loc(i)})
                        serieslegtheta{j} = vertcat(serieslegtheta{j},SSlegtheta{loc(i)}{j});
                        serieslegx{j} = vertcat(serieslegx{j},SSlegx{loc(i)}{j});
                        serieslegy{j} = vertcat(serieslegy{j},SSlegy{loc(i)}{j});
                        sFreq{j} = vertcat(sFreq{j},data(loc(i)).sFreq(j));
                        dutyfactor{j} = vertcat(dutyfactor{j},data(loc(i)).DF(j));
                        sLength{j}= vertcat(sLength{j},data(loc(i)).sLen(j));
                      end
                  end
                  sFrq(j) = nanmean(sFreq{j});
                  df(j) = nanmean(dutyfactor{j});
                  slen(j) = nanmean(sLength{j});
                  sFreqsd(j) = std(sFreq{j});
                  dutyfactorsd(j) = std(dutyfactor{j});
                  sLengthsd(j) = std(sLength{j});
                  [thetafilt,b,a]=lopass_butterworth(serieslegtheta{j},30,500,4);
                  [xfilt,b,a]=lopass_butterworth(serieslegx{j},30,500,4);
                  [yfilt,b,a]=lopass_butterworth(serieslegy{j},30,500,4);
                  
                  serieslegtheta{j} = thetafilt-nanmean(thetafilt);
                  serieslegx{j} = xfilt-nanmean(xfilt);
                  serieslegy{j} = yfilt-nanmean(yfilt);
                  
              end
              if ~isempty(SSlegtheta{loc(i)})
                  sFrq(9) = nanmean(sFrq);
                  df(9) = nanmean(df);
                  slen(9) = nanmean(slen);
                  sFreqsd(9) = nanmean(sFreqsd);
                  dutyfactorsd(9) = nanmean(dutyfactorsd);
                  sLengthsd(9) = nanmean(sLengthsd);
                  Output(count).name = names{s};
                  Output(count).treatment= treatments{t};
                  Output(count).serieslegtheta = serieslegtheta;
                  Output(count).serieslegx = serieslegx;
                  Output(count).serieslegy = serieslegy;
                  Output(count).trials = loc;
                  Output(count).sFreq = sFrq;
                  Output(count).sFreqsd = sFreqsd;
                  Output(count).sLen = slen;
                  Output(count).sLensd = sLengthsd;
                  Output(count).DF = df;
                  Output(count).DFsd = dutyfactorsd;
                  count= count+1;
              end
              clear state sF duty* df sF* slen sL*
          end
          clear loc
      end
  end
  
  dimmleg = nan(8,1);

  %calculate dimensionality for leg
for i=1:size(Output,2)
    for j = 1:8
        if ~isempty (Output(i).serieslegtheta{j})
            [FNN]=fnn_deneme(Output(i).serieslegtheta{j},10,10,15,2);
            dimmleg(j) = max(find(FNN~=0))+1;
            fprintf('Finished procsessing Output for legs %2.0d leg %1.0d \n',i,j);
            if max(find(FNN~=0))+1 >=12
                fprintf('Something does not look right with this trial \n')
            end
        else
            dimmleg(j) = NaN;
        end
    end
    Output(i).dimmleg = dimmleg;
    dimmleg = nan(8,1);
end
% 

  %%Create time delayed state spaces
  %%
  dimmleg =11;
  statethetaleg = cell(1,1);
  embeddimleg = max(max(dimmleg));
  
  %Make state space for legs
  for i = 1:size(Output,2)
    for j = 1:8
        for d = 1:embeddimleg
        statethetaleg{j}(:,d)=Output(i).serieslegtheta{j}(1+(d-1)*timelag:end-(embeddimleg-d)*10);
        stateXleg{j}(:,d)=Output(i).serieslegx{j}(1+(d-1)*timelag:end-(embeddimleg-d)*10);
        stateYleg{j}(:,d)=Output(i).serieslegy{j}(1+(d-1)*timelag:end-(embeddimleg-d)*10);
        end
    end
    Output(i).statethetaleg = statethetaleg;
    Output(i).stateXleg = stateXleg;
    Output(i).stateYleg = stateYleg;
    statethetaleg = cell(1,1);
    stateXleg = cell(1,1);
    stateYleg = cell(1,1);
  end
   clear statetheta* i j d 
%   %%Calculate lyapunov exponent
%   ws = 10;
%   fs=100;
%   period = 1;
%   plotje = 0; % 1 if you want graphs
%   %calculate Lyapunov for legs & body
%   for i = 1:size(Output,2)
%       for j = 1:8
%           [divergence,ldslegtheta]=lds_calc(Output(i).statethetaleg{j},ws,fs,period, plotje);
%           Lyalegtheta{j} = ldslegtheta;
%           [divergence,ldslegx]=lds_calc(Output(i).stateXleg{j},ws,fs,period, plotje);
%           Lyalegx{j} = ldslegx;
%           [divergence,ldslegy]=lds_calc(Output(i).stateYleg{j},ws,fs,period, plotje);
%           Lyalegy{j} = ldslegy; 
%       end
%       Output(i).LyapunovLegtheta = Lyalegtheta;  
%       Output(i).LyapunovLegx = Lyalegx; 
%       Output(i).LyapunovLegy = Lyalegy; 
%   end

        