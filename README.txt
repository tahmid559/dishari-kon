# দিশারী কোণ — GitHub Pages + Supabase

## কী আছে
- বাংলা, মোবাইল-উপযোগী ওয়েবসাইট
- PDF বই আপলোড ও প্রকাশ
- YouTube ভিডিও লিংক দিয়ে ভিডিও প্রকাশ
- সংবাদ/লেখা প্রকাশ
- পাবলিক ভিউ + অ্যাডমিন লগইন
- সার্চ

## ১) GitHub Pages-এ প্রকাশ
1. GitHub-এ নতুন Public repository তৈরি করুন (যেমন `dishari-kon`)।
2. `index.html` ফাইলটি repository-র মূল ফোল্ডারে আপলোড করুন।
3. Settings → Pages → Deploy from a branch → `main` এবং `/ (root)` নির্বাচন করে Save করুন।
4. GitHub যে ওয়েব ঠিকানা দেবে, সেটি দিয়ে সাইট খুলুন।

## ২) Supabase ব্যাকএন্ড তৈরি (ফ্রি প্ল্যান দিয়ে শুরু)
1. https://supabase.com এ গিয়ে নতুন project তৈরি করুন।
2. Project Settings → API থেকে Project URL এবং anon/public key কপি করুন।
3. `index.html`-এর একদম নিচের JavaScript অংশে `SUPABASE_URL` ও `SUPABASE_ANON_KEY`-এ বসান। anon/public key ব্রাউজারে ব্যবহার করার জন্য; কখনো `service_role` key বসাবেন না।
4. Supabase → SQL Editor-এ `setup.sql`-এর সম্পূর্ণ কোড চালান।
5. Supabase → Authentication → Users থেকে নিজের ইমেইল দিয়ে user তৈরি করুন।
6. SQL Editor-এ `setup.sql`-এর শেষের commented UPDATE লাইনটি নিজের ইমেইল বসিয়ে `--` সরিয়ে চালান। এতে ওই user অ্যাডমিন হবে।
7. চাইলে Authentication → URL Configuration-এ GitHub Pages-এর সাইট URL-টি Site URL/Redirect URL-এ যোগ করুন।

## ৩) ব্যবহার
- সাইটে Admin বাটনে চাপুন, Supabase-এ তৈরি ইমেইল-পাসওয়ার্ড দিয়ে লগইন করুন।
- PDF বই আপলোড, YouTube লিংক, অথবা সংবাদ লিখে প্রকাশ করুন।
- সাধারণ দর্শক লগইন ছাড়াই প্রকাশিত কনটেন্ট দেখতে পারবে।

## গুরুত্বপূর্ণ
- শুধু `index.html` GitHub-এ দিলেই ব্যাকএন্ড নিজে থেকে তৈরি হবে না; একবার Supabase project ও SQL সেটআপ জরুরি।
- PDF আপলোড সীমা ৫০ MB। বড় ফাইলের জন্য আলাদা ফাইল হোস্টিং ব্যবহার করুন।
- YouTube ভিডিও URL ব্যবহার করা হয়; ভিডিও ফাইল সরাসরি এখানে আপলোড হয় না।
- শুধু নিজের তৈরি বা ব্যবহারের/বিতরণের অনুমতি আছে এমন বই ও ভিডিও প্রকাশ করুন।
- Supabase `service_role` key কখনো HTML/JavaScript-এ দেবেন না। Admin নিরাপত্তা RLS policy দিয়ে নিয়ন্ত্রিত।
- বিনামূল্যের প্ল্যানে ব্যবহার/স্টোরেজ সীমা থাকে; বেশি ট্রাফিক বা ফাইল হলে খরচ হতে পারে।
