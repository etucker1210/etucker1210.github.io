 function [SSlegrho,SSlegx,SSlegy,SSbodrho,SSbodx,SSbody,Output]= Calc_Lya(data,footfall,timelag)
%%The goal of this function is to:
    %1. import position data (going to start with rho)
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
  SSlegrho = cell(1,numtrials);
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
                posx = data(i).res.pthX(FD{i}(j,index(1)):FD{i}(j,index(2)),j);
                posy = data(i).res.pthY(FD{i}(j,index(1)):FD{i}(j,index(2)),j);
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
                % filter data
                [xfilt,b,a]=lopass_butterworth(Xnew,60,500,4);
                [yfilt,b,a]=lopass_butterworth(Ynew,60,500,4);
                poslegX{i}{j} = xfilt;
                poslegY{i}{j} = yfilt;

                %Make new gaitspace timing.
                tnew = (0:samples-1)/samples*length(xfilt)/500;
                sxnorm = fnval(tnew,csaps(t,xfilt));
                synorm = fnval(tnew,csaps(t,yfilt));
                SSlegx{i}{j}(:,1) = sxnorm;
                SSlegy{i}{j}(:,1) = synorm;
                [theta,rho]= cart2pol(sxnorm-nanmean(sxnorm),synorm-nanmean(synorm));
                SSlegrho{i}{j}(:,1) = rho ;
                clear index a b xfilt yfilt temp* *nan* posx posy... 
                theta rho series* *new samples numstrides t
            else
                posX{i}{j} = [];
                poslegY{i}{j} = [];
                SSlegx{i}{j}= [];
                SSlegy{i}{j} = [];
                SSlegrho{i}{j}= [];
            clear index a b xfilt yfilt temp* *nan* posx posy... 
                theta rho series* *new samples numstrides t sx* sy*
            end
        end
    end
  end
    clear  i j
%    create time series for the body 
for i=1:numtrials  
    if ~isempty(data(i).res) 
        body = data(i).rotXY;
        siz = size(data(i).res.pthX,1);
        padsize = siz-size(body,1);
        if padsize>0
            body = vertcat(body,nan(padsize,3));
        end
        clear siz padsize
        for j=1:8
            if sum(~isnan(FD{i}(j,:)))>=2
                index(1) = find(FD{i}(j,:)== min(FD{i}(j,:)));
                if isnan(body(FD{i}(j,index(1)),1))
                    index(1) = index+1;
                end
                index(2) = find(FD{i}(j,:)== max(FD{i}(j,:)));
                if isnan(body(FD{i}(j,index(2)),1))
                    index(2) = index(2)-1;
                end
                numstrides = diff(index,1);
                samples = numstrides*100;
                posx = body(FD{i}(j,index(1)):FD{i}(j,index(2)),1);
                posy = body(FD{i}(j,index(1)):FD{i}(j,index(2)),2);
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
                % filter data
                [xfilt,b,a]=lopass_butterworth(Xnew,60,500,4);
                [yfilt,b,a]=lopass_butterworth(Ynew,60,500,4);
                posbodX{i}{j} = xfilt;
                posbodY{i}{j} = yfilt;

                %Make new gaitspace timing.
                tnew = (0:samples-1)/samples*length(xfilt)/500;
                sxnorm = fnval(tnew,csaps(t,xfilt));
                synorm = fnval(tnew,csaps(t,yfilt));
                SSbodx{i}{j}(:,1) = sxnorm;
                SSbody{i}{j}(:,1) = synorm;
                [theta,rho]= cart2pol(sxnorm-nanmean(sxnorm),synorm-nanmean(synorm));
                SSbodrho{i}{j}(:,1) = rho ;
                clear index a b xfilt yfilt temp* *nan* posx posy... 
                theta rho series* *new samples numstrides t
            else
                posbodX{i}{j} = [];
                posbodY{i}{j} = [];
                SSbodx{i}{j}= [];
                SSbody{i}{j} = [];
                SSbodrho{i}{j}= [];
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
              seriesleg = cell(1,8);
              seriesbod = cell(1,8);
              sFreq = cell(1,8);
              dutyfactor= cell(1,8);
              sLength= cell(1,8);
              sFreqsd = nan(1,9);
              dutyfactorsd = nan(1,9);
              sLengthsd = nan(1,9);
              for j = 1:8
                  for i = 1:length(loc)
                      if ~isempty(SSlegrho{loc(i)})
                        seriesleg{j} = vertcat(seriesleg{j},SSlegrho{loc(i)}{j});
                        seriesbod{j} = vertcat(seriesbod{j},SSbodrho{loc(i)}{j});
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
                  
              end
              if ~isempty(SSlegrho{loc(i)})
                  sFrq(9) = nanmean(sFrq);
                  df(9) = nanmean(df);
                  slen(9) = nanmean(slen);
                  sFreqsd(9) = nanmean(sFreqsd);
                  dutyfactorsd(9) = nanmean(dutyfactorsd);
                  sLengthsd(9) = nanmean(sLengthsd);
                  Output(count).name = names{s};
                  Output(count).treatment= treatments{t};
                  Output(count).seriesleg = seriesleg;
                  Output(count).seriesbod = seriesbod;
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
  
%   dimmleg = nan(8,size(Output,2));
%   dimmbod = nan(8,size(Output,2));
%   %calculate dimensionality for leg
% for i=1:size(Output,2)
%     for j = 1:8
%         if ~isempty (Output(i).seriesleg{j})
%             [FNN]=fnn_deneme(Output(i).seriesleg{j},10,10,15,2);
%             dimmleg(j) = max(find(FNN~=0))+1;
%             fprintf('Finished procsessing Output for legs %2.0d leg %1.0d \n',i,j);
%             if max(find(FNN~=0))+1 >=12
%                 fprintf('Something does not look right with this trial \n')
%             end
%         end
%     end
%     Output(i).dimmleg = dimmleg;
%     
% end
% %calculate dimensionality for body per leg
% for i=1:size(Output,2)
%     for j = 1:8
%         if ~isempty(Output(i).seriesbod{j})
%             [FNN]=fnn_deneme(Output(i).seriesbod{j},10,10,15,2);
%             dimmbod(j) = max(find(FNN~=0))+1;
%             fprintf('Finished procsessing Output for body %2.0d leg %1.0d \n',i,j);
%             if max(find(FNN~=0))+1 >=12
%                 fprintf('Something does not look right with this trial \n')
%             end
%         end
%     end
%     Output(i).dimmbod = dimmbod;
%     
% end

  %%Create time delayed state spaces
  %%
  dimmleg =11;
  dimmbod=11;
  stateRholeg = cell(1,1);
  stateRhobod = cell(1,1);
  embeddimleg = max(max(dimmleg));
  embeddimbod = max(max(dimmbod));
  %Make state space for legs
  for i = 1:size(Output,2)
    for j = 1:8
        for d = 1:embeddimleg
        stateRholeg{j}(:,d)=Output(i).seriesleg{j}(1+(d-1)*timelag:end-(embeddimleg-d)*10);
        end
    end
    Output(i).stateleg = stateRholeg;
    stateRholeg = cell(1,1);
  end
  %make state space for body
  for i = 1:size(Output,2)
    for j = 1:8
        for d = 1:embeddimbod
        stateRhobod{j}(:,d)=Output(i).seriesbod{j}(1+(d-1)*timelag:end-(embeddimbod-d)*10);
        end
    end
    Output(i).statebod = stateRhobod;
    stateRhobod = cell(1,1);
  end
 clear stateRho* i j d 
  %%Calculate lyapunov exponent
  ws = 10;
  fs=100;
  period = 1;
  plotje = 0; % 1 if you want graphs
  %calculate Lyapunov for legs & body
  for i = 1:size(Output,2)
      for j = 1:8
          stateleg = Output(i).stateleg{j};
          [divergence,ldsleg]=lds_calc(stateleg,ws,fs,period, plotje);
          Lyaleg{j} = ldsleg;
          clear stateleg 
          statebod = Output(i).statebod{j};
          [divergence,ldsbod]=lds_calc(statebod,ws,fs,period, plotje);
          Lyabod{j} = ldsbod;
      end
      Output(i).LyapunovLeg = Lyaleg;
      Output(i).LyapunovBod = Lyabod;
  end

        