unit BasicOperations;

interface

uses
  System.SysUtils, Vcl.Dialogs;

type
  TMatrix =  array of array of integer; // динамический массив (матрица)

  // задание размерности матрицы (numRow- кол-во строк, numCol- кол-во столбцов)
  procedure matrixSize(var arr: TMatrix; numRow, numCol: integer);

  // функция генерации случайного числа из заданного интервала,
  // включая границы
  function randNum(min, max: integer): integer;

  // функция генерации случайного числа из заданного интервала,
  // включая границы и не равного ex
  function randExcept(min, max, ex: integer): integer;

  //генерация уникальных чисел массива от одного до size
  function randUniqArr(size: integer): TMatrix;

  // перемешивает матрицу с домножением (arr- матрица, amount- кол-во перемешиваний
  // min, max - диапазон домножения)
  function multMixMatrix(arr: TMatrix; amount, min, max: integer): TMatrix;

  // генерирует матрицу с заданным определителем
  // (size- размерность, det- определитель)
  function matrixGivenDet(size, det: integer): TMatrix;

  // генерирует матрицу случайных чисел в интервале min, max
  // заданной размерности size
  function randMatrix(numRow, numCol, min, max: integer): TMatrix;

  //перемножает две матрицы и возвращает произведение
  function multMatrix(fistMat, secondMat: TMatrix): TMatrix;

  // возвращает транпонированную матрицу, переданную в качестве аргумента
  function matrixTranspose(mat: TMatrix): TMatrix;

  // возведение числа в степень
  function intPower(num, pow: integer): integer;

  // строит матрицу на основе линейных комбинаций
  function linComb(size: integer): TMatrix;

  //система с одним решением
  function sluOnceSolution: TMatrix;

  //система с бесконечным числом решенией
  function sluInfiniteSolution: TMatrix;

  //система без решений
  function sluNoSolution: TMatrix;


implementation

  procedure matrixSize(var arr: TMatrix; numRow, numCol: integer);
  var
    i: integer;
  begin
    SetLength(arr, numRow);
    for i := low(arr) to high(arr) do
      SetLength(arr[i], numCol);
  end;

  //////////////////////////////////////////////////

  function randNum(min, max: integer): integer;
  var
    num: integer;
  begin
    num := min + random(max - min + 1);
    result := num;
  end;

  ///////////////////////////////////////////////////

  function randExcept(min, max, ex: integer): integer;
  var
    num: integer;
  begin

    num := min + random(max - min + 1);

    if(NOT(num = ex)) then
      result := num
    else
      result := randExcept(min, max, ex);

  end;

  ////////////////////////////////////////////////////////////////////////

  function multMixMatrix(arr: TMatrix; amount, min, max: integer): TMatrix;
  var
    firstRow, secondRow, multiplier, i, j: integer;
  begin
    for i := 0 to amount do
    begin

      firstRow := randNum(low(arr), high(arr));
      secondRow := randExcept(low(arr), high(arr), firstRow);
      multiplier := randExcept(min, max, 0); //не домножаем на ноль

      for j := low(arr[firstRow]) to high(arr[firstRow]) do
        arr[firstRow][j] :=  arr[firstRow][j] + arr[secondRow][j] * multiplier;
    end;
    result := arr;
  end;

  //////////////////////////////////////////////////////

  function matrixGivenDet(size, det: integer): TMatrix;
  var
    matr: TMatrix;
    i, j, randIndex: integer;
  begin

    matrixSize(matr, size, size);
    randIndex := randNum(low(matr), high(matr));

    for i := low(matr) to high(matr) do
    begin
      for j := low(matr[i]) to high(matr[i]) do
      begin
        if(i = j) then
        begin
          if (i = randIndex) then
            matr[i][j] := det
          else
            matr[i][j] := 1;
        end
        else if (i < j) then
          matr[i][j] := randNum(-5, 5)
        else
          matr[i][j] := 0;
      end;
    end;
    result := multMixMatrix(matr, 10, -2, 2);
  end;

  /////////////////////////////////////////////////////////////////

  function randMatrix(numRow, numCol, min, max: integer): TMatrix;
  var
    mat: TMatrix;
    i, j: integer;
  begin

    matrixSize(mat, numRow, numCol);

    for i := Low(mat) to High(mat) do
      for j := Low(mat[i]) to High(mat[i]) do
        mat[i][j] := randNum(min, max);

    result := mat;
  end;

  ////////////////////////////////////////////////////////////////

  function multMatrix(fistMat, secondMat: TMatrix): TMatrix;
  var
    mat: TMatrix;
    i, j, k: integer;
  begin
    matrixSize(mat, Length(fistMat), Length(secondMat[Low(secondMat)]));

    for i := Low(mat) to High(mat) do
      for j := Low(mat[i]) to High(mat[i]) do
      begin
        mat[i][j] := 0;
        for k := Low(secondMat) to High(secondMat) do
          mat[i][j] := mat[i][j] + fistMat[i][k] * secondMat[k][j];
      end;

    result := mat;

  end;

  //////////////////////////////////////////////////////////////

  function matrixTranspose(mat: TMatrix): TMatrix;
  var
    i, j: integer;
    transMat: TMatrix;
  begin
    matrixSize(transMat, Length(mat[Low(mat)]), Length(mat));

    for i := Low(transMat) to High(transMat) do
      for j := Low(transMat[i]) to High(transMat[i]) do
        transMat[i][j] := mat[j][i];

    result := transMat;
  end;

  ///////////////////////////////////////////////////////////////

  function intPower(num, pow: integer): integer;
  var
    i, mult: integer;
  begin
    mult := num;
    for i := 0 to pow - 2 do
      mult := mult * num;
  end;

  ///////////////////////////////////////////////////////////////


  ////////////////////////////////////////////////////////////////

  function randUniqArr(size: integer): TMatrix;
  var
    i, j, num: integer;
    mat: TMatrix;
    flag: boolean;
  begin

    matrixSize(mat, 1, size);

    i := 0;

    while i < size do
    begin

      flag := true;
      num := randNum(1, size);
      j := 0;
      while j < i do
      begin
        if mat[0][j] = num then
        begin
          flag := false;
          break;
        end;
        j := j + 1;
      end;

      if flag then
      begin
        mat[0][i] := num;
        i := i + 1;
      end;

    end;
    result := mat;
  end;

  ///////////////////////////////////////////////////////////////

  function linComb(size: integer): TMatrix;
  var
    i, ps, vs, ts, chs, k: integer;
    mat, strArr: TMatrix;
  begin

    matrixSize(mat, size, size);

    strArr := randUniqArr(size);

    ps := strArr[0][0] - 1;
    vs := strArr[0][1] - 1;
    ts := strArr[0][2] - 1;

    k := randExcept(-3, 3, 0);

    for i := Low(mat[ps]) to High(mat[ps]) do
    begin
      mat[ps][i] := randExcept(-5, 5, 0);
      mat[vs][i] := randExcept(-5, 5, 0);

      mat[ts][i] := mat[vs][i] + k * mat[ps][i];
    end;

    result := mat;
  end;

  /////////////////////////////////////////////////////

  function sluOnceSolution: TMatrix;
  var
    det, i, j, k: integer;
    mat, matExt: TMatrix;
    cofArr: array[0..2] of integer;
  begin

    for i := Low(cofArr) to High(cofArr) do
      cofArr[i] := randNum(-3, 3);


    det := randExcept(-5, 5, 0);
    mat := matrixGivenDet(3, det);

    matrixSize(matExt, 3, 4);

    for i := Low(matExt) to High(matExt) do
      for j := Low(matExt[i]) to High(matExt[i]) do
      begin
        if j <> High(matExt[i]) then
          matExt[i][j] := mat[i][j]
        else
        begin
          matExt[i][j] := 0;
          for k := Low(mat[i]) to High(mat[i]) do
            matExt[i][j] := matExt[i][j] + mat[i][k] * cofArr[k];
        end;
      end;

    result := matExt;

  end;

  ///////////////////////////////////////////////////////////

  function sluInfiniteSolution: TMatrix;
  var
    i, j, k: integer;
    mat, matExt: TMatrix;
    cofArr: array[0..2] of integer;
  begin
    for i := Low(cofArr) to High(cofArr) do
      cofArr[i] := randNum(-3, 3);

    mat := linComb(3);

    matrixSize(matExt, 3, 4);

    for i := Low(matExt) to High(matExt) do
      for j := Low(matExt[i]) to High(matExt[i]) do
      begin
        if j <> High(matExt[i]) then
          matExt[i][j] := mat[i][j]
        else
        begin
          matExt[i][j] := 0;
          for k := Low(mat[i]) to High(mat[i]) do
            matExt[i][j] := matExt[i][j] + mat[i][k] * cofArr[k];
        end;
      end;

    result := matExt;
  end;

  ////////////////////////////////////////////////////////////////

  function sluNoSolution: TMatrix;
  var
    i, j, ps, vs, ts, chs, k, tsInd: integer;
    mat, strArr, matExt: TMatrix;
    cofArr: array[0..3] of integer;
  begin
    matrixSize(mat, 4, 4);

    strArr := randUniqArr(4);

    ps := strArr[0][0] - 1;
    vs := strArr[0][1] - 1;
    ts := strArr[0][2] - 1;
    chs := strArr[0][3] - 1;

    k := randExcept(-3, 3, 0);

    for i := Low(mat[ps]) to High(mat[ps]) do
    begin
      mat[ps][i] := randExcept(-5, 5, 0);
      mat[vs][i] := randExcept(-5, 5, 0);
      mat[ts][i] := mat[vs][i] + k * mat[ps][i];
      mat[chs][i] := randExcept(-5, 5, 0);
    end;

    matrixSize(matExt, 4, 5);

    for i := Low(cofArr) to High(cofArr) do
      cofArr[i] := randNum(-4, 4);

    for i := Low(matExt) to High(matExt) do
      for j := Low(matExt[i]) to High(matExt[i]) do
      begin
        if j <> High(matExt[i]) then
          matExt[i][j] := mat[i][j]
        else
        begin
          matExt[i][j] := 0;
          for k := Low(mat[i]) to High(mat[i]) do
            matExt[i][j] := matExt[i][j] + mat[i][k] * cofArr[k];
        end;
      end;

    tsInd := High(matExt[ts]);

    matExt[ts][tsInd] := randExcept(matExt[ts][tsInd] - 5, matExt[ts][tsInd] + 5, matExt[ts][tsInd]);

    result := matExt;

  end;


end.
