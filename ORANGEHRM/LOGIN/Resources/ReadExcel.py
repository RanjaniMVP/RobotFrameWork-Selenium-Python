import xlrd
from robot.api.deco import keyword




def Read_Excel_MainSheet(filepath, sheetname, testcasename):
    Wb = xlrd.open_workbook(filepath)
    Ws = Wb.sheet_by_name(sheetname)
    Row = Ws.nrows
    Column = Ws.ncols
    StartRow = 0
    dicts = {}
    for nRowIndex in range(0, Row):
        colAttr = Ws.cell_value(nRowIndex, 0)
        if colAttr.strip() == testcasename:
            TestRow = nRowIndex
            # print(str(nRowIndex)+colAttr)

    for nColIndex in range(0,Column):
        keyAttr = Ws.cell_value(TestRow-1, nColIndex)
        print(keyAttr)
        colAttr = Ws.cell_value(TestRow,nColIndex)
        if isinstance(colAttr, float) and colAttr.is_integer():
            colAttr = int(colAttr)
        dicts[keyAttr] = colAttr

    for key in dicts:
        print(key)
        print(dicts[key])
    return dicts



