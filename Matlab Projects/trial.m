for number = 1:length(first.forcefname);
    switch first.ff.forcefoot{number*2}
        case 'L'
            hip = first.rotXYZ{1,number}(first.ff.forcestep(number*2,1):first.ff.forcestep(number*2,2),51);
            toe = first.rotXYZ{1,number}(first.ff.forcestep(number*2,1):first.ff.forcestep(number*2,2),78);
        case 'R'
            hip = first.rotXYZ{1,number}(first.ff.forcestep(number*2,1):first.ff.forcestep(number*2,2),81);
            toe = first.rotXYZ{1,number}(first.ff.forcestep(number*2,1):first.ff.forcestep(number*2,2),108);
    end
    
    f(number,1) = min(find(hip >= toe))
    f(number,2) = max(find(hip >= toe))
    clear hip toe
end
