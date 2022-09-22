package util;

import java.io.*;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ReadWriteExcel 
{
	private int xRows, xCols;
	private String[][] xData; 
	
	public int getxRows() {
		return xRows;
	}

	public void setxRows(int xRows) {
		this.xRows = xRows;
	}

	public String[][] getData() {
		return xData;
	}

	public void setData(String[][] xData) {
		this.xData = xData;
	}

	public int getxCols() {
		return xCols;
	}

	public void xlRead(String sPath,int sheetNo) throws Exception{
		File myFile = new File(sPath);
		
		FileInputStream file = new FileInputStream(myFile);
		
		XSSFWorkbook wb = new XSSFWorkbook(file);

		XSSFSheet sheet = wb.getSheetAt(sheetNo);
		xRows = sheet.getLastRowNum()+1;
		xCols = sheet.getRow(0).getLastCellNum();
	
		xData = new String[xRows][xCols];
        for (int i = 0; i < xRows; i++) {
	           XSSFRow row = sheet.getRow(i);
	            for (int j = 0 ; j < xCols ; j++) {
	               XSSFCell cell = row.getCell(j); // To read value from each col in each row
	               String value = cellToString(cell);
	               xData[i][j] = value;
	               }
	        }	
           wb.close();
	    }
	
	    public String cellToString(XSSFCell cell) {
	    	try {
	        CellType type = cell.getCellType();
	        
	        Object result;
	        switch (type) {
	            case NUMERIC: //0
	                result = cell.getNumericCellValue();
	                break;
	            case STRING: //1
	                result = cell.getStringCellValue();
	                break;
	            case FORMULA: //2
	                throw new RuntimeException("We can't evaluate formulas in Java");
	            case BLANK: //3
	                result = "-";
	                break;
	            case BOOLEAN: //4
	                result = cell.getBooleanCellValue();
	                break;
	            case ERROR: //5
	                throw new RuntimeException ("This cell has an error");
	            default:
	                throw new RuntimeException("We don't support this cell type: " + type);
	        }
	        return result.toString();
	    	}catch(Exception e) {
	    		return "";
	    	}
	    }
	    
	    public void xlWrite(String xlPath, String[][] xldata) throws Exception {
			
	    	XSSFWorkbook wb = new XSSFWorkbook();

	        XSSFSheet sheet = wb.createSheet("TESTRESULTS");
	        
	    	for (int i = 0; i < xldata.length; i++) {
	    		
		        XSSFRow row = sheet.createRow(i);
		        
		        for (int j = 0; j < xldata[i].length; j++) {
		        	XSSFCell cell = row.createCell(j);
		        	cell.setCellType(CellType.STRING);
		        	cell.setCellValue(xldata[i][j]);	        	
		        }
	    	}
	    	    FileOutputStream fOut = new FileOutputStream(xlPath);
	            wb.write(fOut);
		        wb.close();
		        fOut.flush();
		        fOut.close();
	    }
	}
