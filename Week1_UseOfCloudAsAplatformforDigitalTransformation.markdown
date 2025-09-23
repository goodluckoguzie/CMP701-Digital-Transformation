# Using the Azure Pricing Calculator for Virtual Machine Cost Estimation

## Quick Introduction
Azure is a cloud platform where you can rent computing power and storage, like borrowing a supercomputer from Microsoft, and the Azure Pricing Calculator helps estimate the cost of that rental.

## Step-by-Step: How to Get a VM Cost
### Step 0 — Understand the Purpose
When you create an app (e.g., a game or website), it needs a computer on the internet, called a virtual machine (VM). The Azure Pricing Calculator helps you estimate the monthly cost of renting a VM to avoid unexpected bills. Your lab requires using the calculator to complete the Business-tier table.

### Step 1 — Open the Azure Pricing Calculator
- **What to do**: Search “Azure Pricing Calculator” in a web browser and open the Microsoft page. You’ll see a page listing Azure products with a search box for “Virtual Machines.”
- **Why**: This tool converts VM specifications (CPU, RAM, disk, OS) into a monthly price.

### Step 2 — Set Region and Currency
- **What to do**: Find the Region/Currency controls (usually top-right). Set Region to UK South and Currency to GBP (£) if not already set.
- **Why**: Prices vary by region. The lab specifies UK South, overriding the default East US.

### Step 3 — Add a Virtual Machine Product Card
- **What to do**: In the product picker, type “Virtual Machines” and click Add. A VM configuration box will appear on the right.
- **Why**: This card lets you specify the machine type, operating system, disk size, and quantity.

### Step 4 — Configure VM Details
For each VM (VM1, VM2, VM3, VM4) in the lab’s table, set:
- **A. Region**: UK South.
- **B. Operating System**: VM1–VM3 = Ubuntu (Linux), VM4 = Windows (per lab).
- **C. Instance Size**: Choose an instance matching the lab’s cores and RAM (e.g., 4 cores/~7 GB RAM = select 4 vCPUs, ~7–8 GB RAM instance). If the exact name (e.g., “S4”) isn’t available, pick a modern equivalent.
- **D. Quantity**: Set to 1 for “x1” or 2 for “x2” (e.g., VM3’s “S70 x2” means two VMs, so quantity = 2).
- **Why**: These settings determine the compute cost based on instance, OS, and quantity.

### Step 5 — Add Disks
- **What to do**: In the VM card, open the Disks section. Select Standard SSD (or lab-specified type) and set disk size to 285 GB for rows listing “285 GB ×1.”
- **Why**: Disks are priced separately from CPU/RAM, and the lab specifies disk sizes.

### Step 6 — Review the Estimate
- **What to do**: Check the right-hand estimate pane for the monthly cost of each VM and the total.
- **Why**: This shows the per-VM and overall costs based on your settings.

### Step 7 — Export to Excel
- **What to do**: In the estimate pane, click Export → Excel (or CSV) to download a spreadsheet with VM details and costs.
- **Why**: The lab requires submitting this Excel file to show your settings and prices.

### Step 8 — Safety Tips
- If creating VMs in the Azure portal (not calculator), turn them off when not in use to avoid burning credits or money.
- Calculator estimates are safe—they don’t create real VMs, only plan costs.

## Example Cost Calculation
If the calculator shows a VM compute price of £0.20/hour:
- Azure uses 730 hours/month (24 hours × ~30.4 days).
- Hourly × 730 = Monthly:  
  £0.20 × 700 = £140.00  
  £0.20 × 30 = £6.00  
  Total = £146.00/month for compute (add disk cost from estimate).
- **Note**: If the calculator shows a monthly price, use it directly—this math explains the hourly-to-monthly conversion.

## Checklist for Lab Submission
- Open Azure Pricing Calculator.
- Set Region = UK South, Currency = GBP.
- Add Virtual Machines item.
- For each VM: set OS, instance size (e.g., 4 cores = 4 vCPUs), disk = 285 GB, quantity.
- Check estimate pane for monthly cost.
- Export to Excel and attach to coursework.

## Estimated Costs for Business Tier
The provided markdown file serves as a detailed step-by-step guide for using the Azure Pricing Calculator to estimate costs for the Business Tier VMs in the lab exercise. However, it does not fully address all aspects of the lab questions:

- **Q1 (Web Tier costs)**: The lab explicitly asks to "Calculate Web Tier VM machine cost for all VM." The markdown does not cover this—it focuses only on the Business Tier table. Based on the lab diagram (visible in the attached images and referenced on page 10 of the PDF), the Web Tier appears to involve similar VMs (likely with their own specs, such as 2-4 VMs with comparable CPU/RAM/disk configurations), but no specific table is provided in the PDF for Web Tier. You would need to apply the same process from the markdown to calculate those costs separately using the pricing calculator. If the Web Tier specs aren't detailed in your lab materials, assume similar configurations to Business Tier or check with your instructor.

- **Business Tier table**: The markdown explains how to fill this out but does not provide actual numerical costs in the table (e.g., upfront and monthly $ values for each VM). It teaches the method, including exporting to Excel, but you'll need to run the calculator yourself to get current numbers, as prices fluctuate (e.g., due to region, date, or Azure updates). As of September 23, 2025, here are approximate pay-as-you-go estimates for UK South region in GBP (based on public pricing data; use the calculator for precision, assuming F4s v2 for 4 vCPU/8 GB equivalents and F8s v2 for 8 vCPU/16 GB, 730 hours/month, Standard SSD for OS disks, and LRS redundancy):

  | Business Tier | CPU     | Memory   | Disk          | Data Disk             | OS Type | Upfront Cost (£) | Monthly Cost (£) |
  |---------------|---------|----------|---------------|-----------------------|---------|------------------|------------------|
  | VM1          | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S4 (32 GB) | Ubuntu  | 0                | ~123 (compute ~102 + OS disk ~21 + data disk ~0) |
  | VM2          | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S4 (32 GB) | Ubuntu  | 0                | ~123 (same as VM1) |
  | VM3          | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S70 x2 (16 TB each) | Ubuntu | 0 | ~483 (compute ~102 + OS disk ~21 + data disks ~360) |
  | VM4          | 8 Cores | 16 GB RAM | 0 (assume minimal/default ~64 GB) | Standard SSD – E3 (16 GB) | Windows | 0 | ~293 (compute ~292 + OS disk ~0 + data disk ~1) |

  *Notes on estimates*: 
  - Compute: Linux VMs ~£0.14/hour (~£102/month); Windows ~£0.40/hour (~£292/month).
  - Disks: Standard HDD billed on provisioned space (~£0.011/GB/month). Standard SSD ~£0.072/GB/month. 285 GB OS disk priced as custom size. S70 (16 TB) ~£180/month each. These are rough—Azure bills prorated hourly, and Standard HDD uses provisioned size.
  - Total may vary with exact instance choice (e.g., no exact 7 GB match, so used ~8 GB), taxes, or promotions. Export from calculator for submission.

- **Export to Excel**: The markdown covers this step well—it's required for the lab submission to show your work.

- **Other lab elements**: The markdown is focused on the pricing exercise and doesn't cover the full lab, such as creating the Azure Student Account (Steps 1-7), reading the articles on cost management (Step 8), or taking the Azure Fundamentals course (recommended in Step 7). If your coursework requires evidence of those (e.g., screenshots or notes), they're not included.

In summary, the markdown answers the Business Tier part of the exercise effectively as a tutorial, but to fully complete the lab, you'll need to:
1. Calculate and document Web Tier costs similarly (if specs are available).
2. Run the pricing calculator to fill in/extract actual current costs for both tiers.
3. Submit the exported Excel file(s) as specified.

## Estimated Costs for Web Tier
The lab asks to calculate the Web Tier VM machine cost for all VM, but does not provide a table with specifications like for the Business Tier. Based on the diagram, the Web Tier appears to have two VMs behind a load balancer. Assuming each has similar specifications to VM1 (4 Cores, 7 GB RAM, 285 GB disk, Standard S4 data disk, Ubuntu), the individual cost would be the same as VM1, and the total for the Web Tier would be 2 × £123 = £246 per month.

If the specs are different, adjust accordingly in the calculator.

| Web Tier | CPU     | Memory   | Disk          | Data Disk             | OS Type | Upfront Cost (£) | Monthly Cost (£) |
  |----------|---------|----------|---------------|-----------------------|---------|------------------|------------------|
  | VM1      | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S4 (32 GB) | Ubuntu  | 0                | ~123 |
  | VM2      | 4 Cores | 7 GB RAM | 285 GB x1    | Standard – S4 (32 GB) | Ubuntu  | 0                | ~123 |
  | Total    |         |          |               |                       |         | 0                | ~246 |