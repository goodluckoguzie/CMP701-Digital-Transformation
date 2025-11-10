# Week 1: Use of Cloud as a Platform for Digital Transformation

## Overview
This markdown provides a clear, step-by-step guide to completing the lab exercise for CMP701 – Lab 01. It focuses on using the Azure Pricing Calculator to estimate costs for the N-tier application described in the lab manual. We'll explain the tiers, guide you through the calculation process for both the Web Tier and Business Tier, and provide estimated costs based on current pricing (as of September 2025). Remember, actual prices may vary slightly—always use the calculator for your submission and export to Excel as required.

## Understanding the N-Tier Application Tiers
The lab describes a Windows N-tier application on Azure, which is a common architecture for scalable apps (e.g., a food delivery app). It separates concerns into layers (tiers) for better maintainability, security, and performance. Here's a simple explanation of each tier mentioned in the diagram:

- **Web Tier**: This is the front-end layer that handles user interactions. It receives requests from clients (e.g., browsers or mobile apps), serves web pages or APIs, and passes requests to the Business Tier. In the diagram, it shows two VMs behind a load balancer for redundancy and scalability. These VMs run web servers (e.g., IIS or Apache) and are typically lightweight.

- **Business Tier**: This middle layer contains the application logic. It processes business rules, performs calculations, and coordinates between the Web Tier and Data Tier. The lab provides a table with four VMs (VM1–VM4), each with specific CPU, RAM, disk, and OS configurations. These handle tasks like order processing or user authentication.

- **Data Tier**: This back-end layer stores and manages data (e.g., databases like SQL Server). It ensures data persistence, queries, and integrity. The diagram shows a SQL Server VM or instance.

- **Jump Box**: A secure intermediary server (bastion host) used to access other resources in the network without exposing them directly to the internet. It's for administrative access.

- **AD Server**: Active Directory server for identity management, authentication, and authorization across the system.

The exercise focuses on calculating VM costs for the Web Tier and completing the Business Tier table. Specs for the Web Tier aren't provided in a table, so we'll assume they are similar to the Business Tier's VM1/VM2 (based on typical setups: 4 cores, 7 GB RAM, 285 GB disk, Standard S4 data disk, Ubuntu OS). There appear to be two VMs in the Web Tier. If your instructor provides different specs, adjust accordingly.

## Quick Introduction to Azure Pricing
Azure is a cloud platform where you rent computing power and storage, like borrowing a supercomputer from Microsoft. The Azure Pricing Calculator helps estimate costs based on your configurations (e.g., VM size, OS, disks) to avoid surprises. Prices are pay-as-you-go, vary by region (use UK South as per your location), and are in GBP (£). We'll use approximate 2025 prices here, but run the calculator yourself for accuracy.

## Step-by-Step Guide: Using the Azure Pricing Calculator
Follow these steps to calculate costs. This process applies to both tiers—repeat for each VM.

### Step 0 — Understand the Purpose
VMs are virtual computers in the cloud for running apps. The calculator estimates monthly rental costs based on specs like CPU, RAM, OS, and disks. Your lab requires this for the Web and Business Tiers to plan budgets. Export to Excel for submission.

### Step 1 — Open the Azure Pricing Calculator
- **What to do**: In a web browser, go to [https://azure.microsoft.com/en-gb/pricing/calculator/](https://azure.microsoft.com/en-gb/pricing/calculator/). You'll see a list of products with a search box.
- **Why**: This free tool simulates costs without creating resources.

### Step 2 — Set Region and Currency
- **What to do**: At the top, set Region to "UK South" and Currency to "British Pound (£)" if not default.
- **Why**: Prices differ by location (UK South is closer to you, potentially cheaper/low-latency). Lab overrides default (East US).

### Step 3 — Add Virtual Machines
- **What to do**: Search for "Virtual Machines" and click "Add". A configuration card appears.
- **Why**: This lets you define VM details.

### Step 4 — Configure VM Details (Repeat for Each VM)
- **Region**: UK South.
- **Operating System**: Linux (Ubuntu) for most; Windows for VM4.
- **Type**: Pay as you go (default for lab).
- **VM Size/Instance**: Select a match, e.g., "F4s v2" (4 vCPUs, 8 GB RAM) for 4 cores/~7 GB. Use "F8s v2" (8 vCPUs, 16 GB) for VM4. Filter by "Compute optimized" > "Fsv2-series".
- **Quantity**: 1 (or 2 for VM3 if "x2" means two instances).
- **Why**: Matches lab specs for accurate compute cost (CPU/RAM/OS).

### Step 5 — Add Disks
- **What to do**: In the card, expand "Disks". For OS Disk: Standard SSD, size 285 GB (or closest; type custom size). For Data Disk: Add disk (e.g., Standard HDD, S4 32 GB for VM1/VM2; two S70 16 TB for VM3; Standard SSD E3 16 GB for VM4).
- **Why**: Disks are separate costs. Lab specifies sizes/types. Standard HDD is cheaper but slower; SSD faster.

### Step 6 — Review Estimate
- **What to do**: See the right pane for hourly/monthly breakdown (assumes 730 hours/month).
- **Why**: Shows total per VM. Add items for multiple VMs.

### Step 7 — Export to Excel
- **What to do**: Click "Export" > "Excel" in the estimate pane.
- **Why**: Lab requires this file to verify your configs and prices.

### Step 8 — Safety Tips
- Calculator is simulation-only—no charges.
- If deploying real VMs later, shut them down when unused to save credits (lab warns about this).
- Use free tier services where possible for coursework.

## Example Cost Calculation
If compute is £0.14/hour: Monthly = £0.14 × 730 ≈ £102. Add disks (e.g., 285 GB SSD ≈ £21). This explains hourly to monthly conversion.

## Completing the Exercise: Web Tier Costs
The lab asks to calculate costs for all Web Tier VMs. No table provided, but diagram shows two VMs. Assuming specs like Business Tier VM1 (4 Cores, 7 GB RAM, 285 GB x1 Disk, Standard S4 Data Disk, Ubuntu):

| Web Tier | CPU     | Memory   | Disk          | Data Disk             | OS Type | Upfront Cost (£) | Monthly Cost (£) |
|----------|---------|----------|---------------|-----------------------|---------|------------------|------------------|
| VM1      | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S4 (32 GB) | Ubuntu  | 0                | ~123 (compute ~102 + OS disk ~21 + data disk ~0) |
| VM2      | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S4 (32 GB) | Ubuntu  | 0                | ~123 (same as VM1) |
| Total    |         |          |               |                       |         | 0                | ~246 |

## Completing the Exercise: Business Tier Costs
Use the lab's table. Fill in costs using the steps above.

| Business Tier | CPU     | Memory   | Disk          | Data Disk             | OS Type | Upfront Cost (£) | Monthly Cost (£) |
|---------------|---------|----------|---------------|-----------------------|---------|------------------|------------------|
| VM1          | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S4 (32 GB) | Ubuntu  | 0                | ~123 (compute ~102 + OS disk ~21 + data disk ~0) |
| VM2          | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S4 (32 GB) | Ubuntu  | 0                | ~123 (same as VM1) |
| VM3
