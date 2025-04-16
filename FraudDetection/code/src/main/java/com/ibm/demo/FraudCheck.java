/*******************************************************************************
 * Copyright (c) 2022 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - Initial implementation
 *******************************************************************************/
package com.ibm.demo;

public class FraudCheck
{
    String sourceAccount;
    String targetAccount;
    String amount;

    public String getSourceAccount()
    {
       return sourceAccount;
    }

    public String getTargetAccount()
    {
       return targetAccount;
    }

    public String getAmount()
    {
       return amount;
    }

    public void setSourceAccount(String iSourceAmount)
    {
       sourceAccount=iSourceAmount;
    }

    public void setTargetAccount(String iTargetAmount)
    {
       targetAccount=iTargetAmount;
    }

    public void setAmount(String iAmount)
    {
       amount=iAmount;
    }

    public FraudCheck()
    {
       sourceAccount="";
       targetAccount="";
       amount="";
    }

}
