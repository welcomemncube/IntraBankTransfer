package com.ibm.demo;

import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.logging.LogEntries;
import org.openqa.selenium.logging.LogEntry;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import java.util.logging.Level;

public class StartLoad 
{
    
    public static void main(String[] args) 
    {
        while(true)
        {
            WebDriver driver = null;
            try
            {
                ChromeOptions options = new ChromeOptions();
                final LoggingPreferences logPrefs = new LoggingPreferences();
                logPrefs.enable(LogType.BROWSER, Level.ALL);
                options.addArguments("--headless");
                options.addArguments("--remote-allow-origins=*");
                options.setAcceptInsecureCerts(true);
                options.setCapability("goog:loggingPrefs", logPrefs);
                driver = new ChromeDriver(options);
                driver.manage().window().setSize(new Dimension(1920, 1080));
                driver.manage().timeouts().scriptTimeout(Duration.ofSeconds(5));
                driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(5));
                driver.get("http://bankui:8000/");
                while(true)
                {
                    login(driver);
                    balance(driver);
                    transfer(driver);
                    // LogEntries entry = driver.manage().logs().get(LogType.BROWSER);
                    // Retrieving all log 
                    // List<LogEntry> logs= entry.getAll();
                    // Print one by one
                    // for(LogEntry e: logs)
                    // {
                        // System.out.println(e);
                    //}
                    System.out.println("Sent requests for login, balance and transfer");
                    Thread.sleep(500);
                }
            }
            catch (Exception e)
            {
                if(driver !=null)
                {
                    System.out.println("Exception caught "+e.getMessage()+ " trying to close browser");
                    driver.close();
                    System.out.println("Trying to close browser");
                    driver.quit();
                }
                e.printStackTrace();
            }
            
        }
    }

    private static void login(WebDriver driver)
    {
        WebElement authenticateTab = driver.findElement(By.id("Authenticate"));
        authenticateTab.click();
        new WebDriverWait(driver, Duration.ofSeconds(5)).until(ExpectedConditions.numberOfElementsToBe(By.id("username"), 1));
        WebElement loginBox = driver.findElement(By.id("username"));
        loginBox.sendKeys("Callum");
        WebElement passwordBox = driver.findElement(By.id("password"));
        passwordBox.sendKeys("oassw0rd");
        WebElement submitLogin = driver.findElement(By.id("login"));
        submitLogin.click();
    }

    private static void balance(WebDriver driver)
    {
        WebElement balanceTab = driver.findElement(By.id("Balance"));
        balanceTab.click();
        WebElement balanceButton = new WebDriverWait(driver, Duration.ofSeconds(5)).until(ExpectedConditions.elementToBeClickable(By.id("balanceButton")));
        balanceButton.click();
    }

    private static void transfer(WebDriver driver)
    {
        WebElement transferTab = driver.findElement(By.id("TransferTab"));
        transferTab.click();
        WebElement transferButton = new WebDriverWait(driver, Duration.ofSeconds(5)).until(ExpectedConditions.elementToBeClickable(By.id("transferButton")));
        WebElement sourceAccountBox = driver.findElement(By.id("sourceAccount"));
        sourceAccountBox.sendKeys("Callum");
        WebElement targetAccountBox = driver.findElement(By.id("targetAccount"));
        targetAccountBox.sendKeys("Kim");
        WebElement amountBox = driver.findElement(By.id("amount"));
        amountBox.sendKeys(Long.toString(System.currentTimeMillis()));
        transferButton.click();
    }
}
