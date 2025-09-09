
A focused engineer is a performant
0:02
engineer and a focused agent is a
0:05
performant agent. Context engineering is
0:08
the name of the game for high value
0:10
engineering in the age of agents. So how
0:13
good are your context engineering
0:16
skills? Do you have a skill issue? Let's
0:18
find out and fix it. There are three
0:20
levels of context engineering and a
0:22
fourth hidden level if you're on the
0:25
bleeding edge pushing into a gentic
0:27
engineering. But first, we have to ask
0:29
why are context engineering techniques
0:32
so important? It's because context
0:34
engineering enables you to manage the
0:37
precious and delicate resource that is
0:40
the context window of your agents like
0:43
clawed code. There are only two ways to
0:46
manage your context window, R and D.
0:48
Let's break down each technique at each
0:51
level and use the R&D framework to
0:54
maximize not what you can do, but what
0:56
your agents can do for you.
1:02
When you boil it down, there are only
1:04
two ways to manage your context window.
1:06
R and D, reduce and delegate. Every
1:10
technique we'll break down right now
1:12
fits into one or both of these buckets.
1:15
Let's start at the beginner level and
1:16
move up to more technical levels of
1:19
context engineering.
B2 Avoid MCP Servers
1:23
Do not load MCP servers unless you need
1:27
them. Take a look at how much of my
1:29
clawed code opus tokens are being chewed
1:32
up by MCP tools. 24.1,000
1:36
tokens. Okay, this is 12% of the entire
1:39
available context window. It's very
1:42
likely you're wasting tokens with MCP
1:45
servers you're not actively using. This
1:47
is a simple, easy, beginner context
1:49
engineering mistake to make. Thankfully,
1:51
the solution is simple. Be very
1:54
purposeful with your MCP servers. We
1:56
have a bad practice of context
1:58
engineering inside of this codebase. We
2:00
have a default MCP.json file that is
2:03
always loading into the context window
2:05
of our agents, chewing up expensive,
2:08
valuable clawed opus tokens. As you can
2:11
see, these numbers will stack up against
2:12
you very quickly. The first thing I
2:14
recommend doing is get rid of this
2:16
MCP.json. Just completely delete this
2:19
thing. Okay, don't use a defaultmcp.json
2:23
for your codebase. And why is that? It's
2:25
because right away clears up our context
2:27
window. Okay, if we type claude now
2:29
context, we've just saved some 20,000
2:32
tokens by not preloading any MCP
2:35
servers. If you do need these, I
2:36
recommend you fire these up by hand.
2:39
claw-smcp config. And now you just pass
2:41
in the config you want. You can see I
2:43
have this specialized file here that
2:45
pulls in just the file crawl mcp server
2:47
and I've suffixed it with 4k. Copy the
2:50
path to this. Paste that there. And if
2:52
you do have some globals that you want
2:54
to overwrite, you can use d-strict
2:57
mcp config. And then you can fire this
2:59
off. And check this out. Flashcontext.
3:01
We're only going to get that 6k tokens
3:04
strictly from the firecraw mcp server.
3:06
And now we can kick off this specialized
3:08
agent focused on just this one MCP
3:11
server. And if you do need every single
3:13
MCP server, explicitly reference it. Be
3:16
very conscious with the state going into
3:19
your context window. There are many
3:21
places to be wasteful as an engineer to
3:23
move fast and break things. The context
3:26
window of your agents is not one of
3:28
them. Here we are of course using the R
3:31
in the R&D framework. We are reducing
B3 Context Prime Over Claude.md
3:35
[Music]
3:37
This technique is a bit controversial,
3:39
especially for beginners, but I strongly
3:42
recommend context priming over using a
3:44
claw.md or any similar autoloading
3:47
memory file. What is context priming and
3:50
why is it superior to claw.md? Let's
3:52
first double click into claw.md. There's
3:55
nothing inherently wrong with this file.
3:57
Like most technology, it's how it's used
4:00
that's the problem. If we boot up a new
4:02
instance here, you can see right away we
4:04
have this error message. Let's address
4:05
this now. Okay, we have built up a
4:08
massive, and I mean massive, claw.md
4:10
file. If we run /context once again and
4:13
monitor what's going on here, we've
4:15
cleaned up our MCP servers, but we
4:17
haven't cleaned up this massive memory
4:20
file. We have a 23,000 token memory
4:22
file. Again, chewing up about 10% of our
4:25
entire context window of expensive Opus
4:29
tokens. I'm of course exaggerating my
4:32
claw.md file here just to showcase this
4:34
idea, but I can almost guarantee you
4:37
there's an engineer out there somewhere
4:38
with a claw.md file that is, you know,
4:41
3,000 lines long. And why is that? It's
4:43
because they and their team, they've
4:45
just constantly added additional items
4:48
to their memory over and over and over
4:50
and over and over again until it's
4:51
become what it is now, a massive glob of
4:55
mess. Okay, even the claw code engineers
4:58
built in a warning here for us. Large
5:00
claw.md will impact performance. The
5:03
claw.md file is incredible for one
5:05
reason. It's a reusable memory file
5:08
that's always loaded into your agent's
5:10
context window. Simultaneously, a
5:12
claw.md file is terrible for the exact
5:16
same reason. It's a reusable memory file
5:18
that's always loaded into your agent's
5:20
context window. So, why is that a
5:22
problem? The problem with always on
5:24
context is that it's not dynamic or
5:26
controllable. Engineering work inside of
5:28
code bases constantly changes. But the
5:31
claw.md file only grows. All right. So
5:34
what's the solution here? The solution
5:36
is context priming. Let's trim down.
5:38
Right? Let's use this claw. Right? It's
5:41
a lot simpler. It's something that we
5:43
always want to add, you know, and and
5:44
take a look at this. Right? It's only 43
5:46
lines. Things that we always want every
5:49
single agent to have. Okay? I have to
5:52
keep stressing that because this is the
5:53
reality of the memory file. It will
5:56
always be added. So, copy this. We'll
5:58
clean this up. Save that. Reset our
6:01
agent here. CLLD is an alias. You can
6:04
check out all the aliases I'm going to
6:05
run throughout this lesson. At the
6:07
bottom of the readme, you can see all
6:09
the aliases right here. All right. So,
6:11
now we have a concise MD file. The
6:13
warning is gone. We can type
6:15
slashcontext.
6:17
And check this out. Our context window
6:19
on boot up on startup is looking much
6:22
much better. 92% free. What's left?
6:25
Right. Our small memory file is down to
6:28
02% right 350 tokens. This is great.
6:31
This is a clear focus agent. Now what do
6:33
we use instead of this large memory
6:36
file? We should context prime. What does
6:39
that mean? Let me show you. /prime and
6:41
we hit enter. Context priming is when
6:43
you use a dedicated reusable prompt, aka
6:46
a custom slash command, to set up your
6:49
agents initial context window
6:51
specifically for the task type at hand.
6:54
So with every codebase, I always set up
6:57
clawed commands prime. You can see here
6:59
we have two prime commands in this
7:01
codebase. Priming is just a reusable
7:04
prompt. We can take a look at this right
7:05
here. It's very simple. It has a concise
7:08
structure, right? We have the purpose.
7:10
We have our run step. We have our read
7:12
step and our report step. Okay. Now our
7:14
agent is ready to go. So it's read a
7:16
couple files. It's read the readme. It
7:19
understands the structure of the
7:20
codebase. And now if we type context,
7:22
our agent has a little bit of
7:24
information about this codebase for this
7:27
specific problem set. And so this
7:29
problem set is of course just gaining a
7:31
general understanding of our codebase.
7:33
So instead of relying on a static always
7:36
loaded memory file, we're using context
7:39
priming to gain full control over the
7:42
initial context of our agents. This is
7:44
very powerful. Unlike the memory file,
7:46
we can prime against several different
7:49
areas of focus in our codebase. Okay, so
7:52
imagine a you know prime bug command,
7:55
right, for bug smashing. Imagine a prime
7:58
chore or prime feature or like we have
8:00
in this codebase, prime CC. Okay, this
8:03
is a focused prompt. It's our hotloading
8:06
memory file for operating with clawed
8:09
code and updating the clawed code files
8:12
inside of this codebase. So, prime don't
8:14
default. Your claw.md file should be
8:17
shrunk to contain only the absolute
8:20
universal essentials that you're 100%
8:23
sure you want loaded 100% of the time.
8:26
You see how powerful that conditional is
8:28
and how strict that conditional is. So,
8:30
be very careful with these memory files.
8:32
keep them slim and instead prefer
8:34
context priming. This way you can build
8:37
out many areas of focus for your agents
8:40
and if you find yourself coming back to
8:42
some specific area of focus, build out a
8:45
prime command for that specific area of
8:47
focus for you and your team. This is the
8:50
beginning of a big agentic level
8:52
technique that we're going to talk about
8:54
in this lesson. You can see we have this
8:56
new experts directory. We'll talk about
8:58
that at the end of this lesson. So now
I2 Use Sub Agents PROPERLY
9:01
we enter the intermediate zone.
9:06
Now it's not just about using sub aents.
9:08
This is about using sub aents properly.
9:11
When you use claw code sub aents, you're
9:13
effectively creating a partially forked
9:16
context window. Let's create a claw
9:18
instance here. If we type context in an
9:21
agent, a brand new agent, you'll notice
9:23
something really interesting. We have
9:24
custom agents here, right? We have three
9:26
custom agents that we can use at any
9:28
point in time. We can of course find
9:30
these inside of claw code under the
9:32
agents directory. We can look at any one
9:34
of these, right? All of our agents here,
9:36
our custom agents only consume 122
9:38
tokens, whereas you can see my rough
9:41
token counter is looking at 900 for this
9:44
one agent. Why? What's going on here?
9:45
What's what's the big difference? The
9:47
big difference here is that when you're
9:48
working with sub agents, you are working
9:51
with system prompts. Okay? There's a
9:54
massive difference between the system
9:55
prompt and a user prompt, right? When
9:58
you're prompting cloud code, you're
9:59
writing user prompts. When you're
10:01
building reusable custom/comands, you're
10:04
writing a user prompt that all gets
10:06
passed right into the agent. This is a
10:08
system prompt, which is nice because it
10:10
means that it's not directly added to
10:12
our primary agents context window. Okay.
10:14
And this advantage of sub agents
10:17
continues. With clock sub agents, we can
10:19
delegate work off of our primary agents
10:22
context window. This is a massive point
10:25
for the D and the R&D framework, right?
10:28
It's delegation. We are keeping contexts
10:31
out of our primary agents context
10:33
window. For example, we can run
10:35
slashload AI docs. And so this is going
10:38
to load AI documentation from our AI
10:41
docs readme. It's going to read through
10:42
all of these items. We can load up the
10:45
AI docs reusable prompt and it's going
10:47
to kick off sub agents to do this work
10:49
for us. So, our primary agents reading
10:50
this file, and this is going to kick off
10:52
however many agents we need to to fetch
10:55
every one of our AD do URLs, right? So,
10:58
it looks like I don't know, what do we
10:59
have here? 10 or 11. You can see this is
11:01
going to get kicked up here pretty soon
11:02
after we do a date check on any file
11:04
here that's older than 24 hours, which I
11:06
think all of them are at this point. And
11:07
so, you can see it's removing these and
11:10
then it's going to fire up these agents.
11:11
There it is. Doc scraper. And this is
11:13
critical, right? A web scrape can
11:15
consume quite a bit of tokens. And so we
11:18
have this load AI docs reusable agentic
11:21
prompt that's going to kick this off.
11:23
You can see that the tokens starting to
11:24
tick up. We already have 3k for each
11:26
agent. This is 3k tokens times 8 or 10
11:30
that isn't added to our primary agent.
11:34
Okay, this is sub agent delegation.
11:36
We're leveraging the context windows of
11:38
our sub aents to do work and keep it out
11:41
of our primary agent. All right, in this
11:44
case, you know, this is a great use case
11:46
for sub aents. You know, we have this
11:47
system prompt here that details exactly
11:50
how to web scrape with firecrawl or web
11:53
fetch, right? Whatever web scraping tool
11:56
you want to use, it has it here. This
11:58
would be a good example for us to fire
11:59
up and load that one MCP server. But now
12:03
these agents are just going to run the
12:05
scrape, which will consume their context
12:07
window, and then they're going to write
12:09
the output files, right? So now we
12:11
should see refreshed AI docs written
12:13
here. Yep, there they are. And there it
12:15
is. Yeah, there's our success command
12:16
here. We of course are using a great
12:18
prompt structure. If we go back to load
12:21
ad docs and collapse here, you can see
12:23
we're using a classic agentic prompt
12:26
workflow format where we have the
12:27
purpose, variables, workflow, and report
12:30
format. Definitely check out the agentic
12:32
prompt engineering extended lesson to
12:35
learn all of the powerful prompt
12:37
structures you can use inside of both
12:39
your system prompts and your user
12:41
prompts like this. This is a classic
12:43
workflow we use a lot throughout TAC and
12:45
throughout our extended lessons. So you
12:47
can see here all the tokens that were
12:49
not added to my primary agents context
12:52
window. We can of course slash context
12:53
to prove that only up to 9K tokens.
12:56
Okay, we delegated work, right? We're
12:58
stepping into the D in the R and D
13:00
framework. There's only two ways to
13:03
manage your context window. reduce
13:04
context entering your primary agent and
13:07
delegate context to sub agents and as
13:10
you'll see in upcoming techniques to
13:12
other primary agents. Cloudco sub agents
13:15
have limitations. Sub aents sit at the
13:17
intermediate level for a reason because
13:19
instead of keeping track of just one set
13:21
of context model prompt and tools, we
13:23
now have to keep track of as many as you
13:26
spawn sub aents. So it becomes super
13:28
important to isolate the work that your
13:31
sub agents are doing into one concise
13:33
prompt to one focused effort. Remember a
13:36
focused agent is a performant agent. Sub
13:39
agents are also a little trickier
13:41
because of the flow of information. The
13:44
flow of information in these multi- aent
13:46
systems is critical. Your primary agent
13:48
is prompting your sub aents and your sub
13:51
aents are responding not to you but back
13:54
to your primary agent. So once we start
13:57
getting into this intermediate advance
13:58
in a gentic level, we have to keep track
14:01
of every agent's core four that we spin
14:04
up. If you're losing track of a single
14:06
agent, right, and you have a bunch of
14:07
wasted context, you probably aren't yet
14:10
ready for sub agents. You probably want
14:11
to spend some more time cleaning up,
14:13
managing, and maintaining clean context
14:16
windows for your existing single primary
14:18
agent. But once you're ready, sub agents
14:20
are a great intermediate level, a great
14:22
intermediate technique to step into
14:24
because you can delegate the entire
14:27
context window to one or more sub
14:30
agents. As you saw here, we saved
14:32
probably 40,000 total tokens and ran all
14:36
this work much faster than it would have
14:38
taken a single primary agent. So, next
ADV2 Use Context Bundles
14:40
up, we have a powerful classic pattern.
14:46
Notice that with each technique from
14:48
beginner to intermediate to advanced and
14:50
soon agentic, we're doing our indeed
14:52
reduce and delegate. We're keeping track
14:54
of our context window at all times and
14:56
we're not outsourcing it. If you want to
14:57
scale your agents, monitoring and
14:59
managing the state of your context
15:01
window is critical for your success. All
15:03
right, just like context priming, you
15:05
can push in loop active context
15:08
management even further with context
15:10
bundles. So with cloud code hooks, you
15:13
can hook into a couple of tool calls to
15:15
create a trail of work that you can use
15:18
to reprime your agents for the next run,
15:21
right? So you can chain together agents
15:23
after the context window has exploded.
15:25
So the great part here is we've been
15:27
using context bundles the entire time.
15:29
So let's collapse everything and open up
15:32
agents. And so agents is becoming a
15:34
additional agentic layer directory where
15:37
you can just put output from operations
15:39
of your agents. You can see we have
15:41
background and we have context bundles.
15:42
Let's click into bundles and let's see
15:44
what we have in this directory. All
15:46
right. So if we click this bundle, we
15:48
have something super simple. We have
15:50
/prime and we have read. If we click
15:52
into this context bundle, you can see we
15:54
have our quick plan. So this was the
15:56
work that happened inside of our
15:58
planner. It read the file as specified
16:00
and then it wrote this plan here for us,
16:02
right? And we have the tool input and we
16:05
have a couple of other things. Right?
16:06
This is powerful. This is a context
16:08
bundle. What we have here is a simple
16:10
appendon log of the work that our cloud
16:14
code instances are doing. These are
16:15
unique based on the day and the hour and
16:18
the session ID. Okay, so how does this
16:20
work exactly? Fire up a YOLO dangerous
16:22
mode instance and we just type prime,
16:25
right? Let's just rerun a prime and
16:26
let's prime our clawed code. Right, so
16:28
we're running our prime command around
16:29
claw code and you can see this context
16:31
bundle was generated. Okay, so there's
16:33
the prompt and let's just let's just pay
16:35
attention to what this does. All right,
16:37
we have read commands, we have search
16:38
commands. Our read commands are all
16:40
getting appended piece by piece. And
16:42
what this does is it gives us a solid
16:44
understanding of 60 to 70% of what our
16:48
previous agents have done. Okay? And so
16:51
why is this important? This is important
16:52
because it tells a fuller story for
16:54
subsequent agents to execute. There's a
16:56
bunch of additional read commands and
16:58
we're getting a log, right? We're
17:00
getting a full-on context bundle of our
17:04
agents context window. Okay, this is a
17:07
very simple yet powerful idea you can
17:09
use to remount instances to get them
17:12
into the exact same state after their
17:14
context window has exploded. It also
17:16
gives us a story because we have the
17:18
prompt operation in here about what the
17:21
context is and why the context is that
17:23
way based on our user prompt. Okay, so
17:25
you know we have this now great, who
17:27
cares? Let's open up a new cloud code
17:29
instance and let's say that this, you
17:31
know, this agent's context window
17:33
exploded. We can with this context
17:34
bundle. Run slash loadbundle.
17:38
Copy the path. Paste it. Hit enter. This
17:41
agent is now going to get the full story
17:43
of the previous agent. It's going to
17:44
dduplicate any read commands. And then
17:47
it's going to create an understanding of
17:49
the work done up till this point. Okay.
17:52
And so imagine this is much larger,
17:54
right? Let's say that it's something
17:55
like, you know, 50 plus lines of reads
17:58
and writes. We can use a context bundle
18:00
to get a much more accurate replay of
18:03
what the previous agent was trying to
18:04
do. You can see here in the summary
18:05
message very concisely the previous
18:07
agent executed this command and loaded
18:09
key findings. That's it. Nine files. You
18:11
can imagine this getting a lot more
18:13
complicated with reads writes in
18:15
additional prompts. But with this simple
18:17
pattern, with this session ID getting
18:20
tracked here inside of this context
18:22
bundle, we're saving a concise execution
18:24
log thanks to cloud code hooks that we
18:27
can reference in subsequent agents. And
18:30
the great part here is of course you can
18:32
conditionally use this. A lot of the
18:34
times you won't need to reload the
18:35
entire context bundle because it won't
18:37
be relevant. But if we needed to, we
18:39
could get the entire replay of the agent
18:42
up to the point in which the context
18:44
overloaded without all of the writes and
18:47
without all the details of all the
18:49
reads. The trim down version is super
18:52
important, right? We're not recording
18:54
every operation. If we do that, we'll
18:55
just end up overflowing the next agent's
18:58
context window. Okay? So, you do have to
19:00
use this selectively, but this gets us,
19:02
you know, 70% of where the previous
19:04
agent was. gets us mounted and restarted
19:07
very quickly. This is another advanced
19:09
contact engineering technique you can
AGE2 Primary Multi-Agent Delegation
19:11
use.
19:14
The focus should always be better agents
19:17
or more agents. When you're adding more
19:19
agents, you're pushing into the D, the
19:21
delegation and the R&D framework. You're
19:24
pushing it to the max. You're using one
19:26
agent for one purpose. And when
19:28
something goes wrong, you fix that piece
19:30
of your workflow. Now, with primary
19:32
multi- aent delegation, we're entering
19:34
the realm of multi- aent systems. In
19:37
TAC, with each lesson, we built up
19:39
variants of a multi- aent pipeline using
19:42
this very technique. And in lesson 8, we
19:44
showcase several different multi- aent
19:46
workflows and systems and UIs, right?
19:48
There are many ways to delegate work at
19:50
a high level, but when you get down to
19:52
it, if you want to create an on the-fly
19:54
primary agent, you have two options. You
19:56
have the CLI and you have SDKs. At the
19:59
mid and high level, we can kick off
20:02
primary agents through prompts, through
20:04
wrapper CLIs, through MCP servers, and
20:07
through UIs. You've likely seen a lot of
20:09
cloud code management systems, and a lot
20:12
of agent systems get built up into their
20:15
own UIs. That is primary agent
20:18
delegation. Now, what's the most
20:20
lightweight version of multi-agent
20:22
delegation you can use ASAP and get
20:25
value out of ASAP? It's a simple
20:27
reusable custom/comand. If you remember
20:30
inside of the claw directory in our
20:32
commands directory, we have
20:34
background.md.
20:36
This is a simple single prompt that
20:39
boots up a background cloud code
20:41
instance. This is the simplest, quickest
20:44
way other than going right through the
20:45
CLI to delegate work to agents. When you
20:48
use a pattern like this, we're pushing
20:51
in to powerful Outloop agent decoding by
20:53
running a single prompt with a single
20:55
agent that does one thing, reports its
20:58
work, and then it finishes. So, let me
21:00
show you exactly what I mean. I'll run
21:02
claude opus in YOLO mode here, and then
21:04
I'll say /background. And you can see
21:06
here, this fires off a full cloud code
21:08
instance in the background. Here's our
21:10
argument hint, prompt, model report
21:12
file. I want to kick off the creation of
21:14
a plan. There's no reason for me to sit
21:17
here in the loop prompting back and
21:19
forth when I can kick off a background
21:21
agent when I can delegate this work
21:23
outside of my primary agents context
21:25
window. Right, we're delegating this
21:27
work out. I can open up some quotes
21:29
here. Paste this in. And this is going
21:31
to kick off a new quick plan. So, we're
21:33
running that plan workflow, that plan a
21:36
gentic prompt again. And this time we're
21:38
building out a Astral UV cloud code
21:41
Python SDK with that same format, right?
21:43
those three files vantic types low-level
21:45
file CLI file. All right, specifying
21:48
where to create it. This is the plan.
21:50
Let's fire it off. This is going to kick
21:51
off a background agent. Okay, and so you
21:55
can see our primary agent getting to
21:56
work here based on the contents of this
21:58
prompt. We can of course see that, you
22:00
know, consistent prompt format where
22:02
you're reusing great prompt structures
22:05
that get work done for us. Again, check
22:07
out the agentic prompt engineering
22:09
extended lesson to learn how to write
22:11
great prompts for the age of agents. And
22:13
it's all inside of the workflow step
22:15
here. Create the agents background
22:16
directory. We have our default values.
22:18
And then this is important. We're
22:20
creating a report file. Okay. And then
22:22
we have this primary agent delegation
22:24
XML wrapper where we're detailing a
22:27
bunch of information for our agent.
22:28
Okay. We are kicking off a cloud code
22:30
instance from cloud code. We have
22:32
compute, orchestrating, compute, agents,
22:35
orchestrating agents. Okay, this is
22:37
where everything is headed. Better
22:39
agents and then more agents. Once you
22:41
master a single context window, you can
22:43
scale it up. There's a format here, blah
22:45
blah blah. Skip to the bottom. But the
22:47
important thing here is that this frees
22:48
up the primary cloud code instance. You
22:50
can see we have a background task.
22:52
Background cloud code kicked off. If we
22:53
open this up, this is the file that our
22:55
agent is going to be reporting to. And
22:58
so cool thing here, we can open up a
23:00
context bundle for this agent, right? So
23:02
if we hit up here, you can see that
23:04
exact prompt background/quickplan
23:07
read blah blah blah blah blah. This
23:08
agent is starting to work. All right,
23:10
it's starting to create this plan. And
23:12
we can see that with the context bundle.
23:14
You can see this is super useful. Adding
23:16
logging, having these trails, there's
23:18
the actual plan just got written there.
23:21
Having this this trail, the story of
23:23
what your agents have done is an
23:24
important agentic pattern. We are
23:27
building up on every context engineering
23:29
technique we've used thus far. This
23:31
agent should report back to its report
23:34
file here. This is a great way to track
23:35
the progress of your agents as they work
23:38
in the background. So you can see here
23:39
we still have that one background task
23:41
running. We should get an update here.
23:43
Our agent has there we go. So you can
23:45
see it's reading its background file
23:47
now. And then soon it's going to put the
23:49
right in here. where we should see this
23:50
come in live as our background delegated
23:54
agent instance is just writing this plan
23:56
for us. There's no reason for me to sit
23:57
in the loop. I know exactly what this
23:59
does. And here is the output. Check this
24:02
out. Progress task completed. It renamed
24:05
this file. I have an instruction to
24:07
rename the file when it finishes.
24:09
130253.
24:11
We can click this. It is now complete. A
24:14
very quick oneprompt agent delegation
24:16
system. It's all about the patterns.
24:19
It's all about taking control of your
24:21
agents context windows and scaling it to
24:24
the moon. The more compute you can
24:25
control, the more compute you can
24:27
orchestrate, the more intelligence that
24:29
you can orchestrate, the more you will
24:31
be able to do the limits on what an
24:33
engineer can do right now is is
24:36
absolutely unknown. Anyone being
24:38
pessimistic, ignore them. Okay? You
24:40
know, don't take my word for this. You
24:42
know, ignore me as well, but investigate
24:45
the optimist in the space. See what they
24:47
can really do. See what see what we're
24:49
really doing here. Okay, we have
24:51
background compute agents calling
24:53
agents. We have the R&D framework, 12
24:56
context engineering techniques. These
24:58
are concrete things. Maybe a couple of
25:00
these techniques fly over your head or
25:01
you're not interested or you think it
25:02
doesn't apply to you. That's fine. Just
25:04
take one, take a couple of these and
25:06
improve your context engineering. Okay.
25:08
The background agent task and multi-
25:11
aent delegation is super important
25:13
because it gets you out the loop. All
25:15
right. This is a big idea we discuss in
25:18
TAC and it extends into context
25:20
engineering. Okay, get out the loop. Set
25:22
up many focused agents that do one thing
25:26
extraordinarily well. All right, in a
25:28
lot of ways, multi- aent delegation is
25:31
just like sub agents, but we get
25:32
complete control, right? We're firing
25:34
off top level primary agents from our
25:37
inloop primary agent here. Okay, so
25:40
there's a lot more control here. this
25:42
background agent and the prompt that I
25:45
passed in. Right? We can just paste this
25:47
prompt. I could have asked for anything
25:49
here, right? This doesn't need to be a
25:51
quick plan. I could have asked for a,
25:53
you know, multi-agent workflow running
25:55
sub agents, right? There's just so many
25:58
ways to build and to use multi- aent
26:00
systems. Let's bring it all back to
26:02
context engineering. The key idea here
26:04
is you can delegate specialized work in
26:07
focus agents by building out some type
26:10
of primary agent delegation workflow.
26:12
You can see here in just one prompt we
26:16
have a full cloud code instance in the
26:19
background doing work for us that we
26:21
know we don't need to monitor anymore.
26:23
And the more you become comfortable and
26:26
the more your agentic engineering skill
26:28
improves, the more you can stop
26:30
babysitting every single Asian instance.
26:33
Okay, this is a big theme in TAC. We
26:34
want to scale from in loop to outloop to
26:37
ZTE. All these big ideas. Let's wrap up
Prepare your Agents for TAC launch
26:40
with potentially one of the most
26:42
powerful context engineering techniques.
26:45
Let's talk about agent experts.
26:50
Take these 12 techniques and apply them.
26:53
Get value out of these techniques. All
26:55
right? Yes, it takes some time. Yes, you
26:57
have to invest. This is not vibe coding.
27:00
Okay? If it if it's easy, a vibe coder
27:02
is probably doing it. And that isn't
27:04
irreplaceable. Okay? That is replaceable
27:07
work. Even one of these can save you
27:09
massive time. But you have 12 here. Pick
27:11
one. Pick a couple. Dive into them.
27:13
Deploy it into your agent coding to
27:15
improve your context engineering.
27:17
Managing your context window is the name
27:19
of the game for effective agent coding.
27:22
And remember, it's not necessarily about
27:24
saving tokens. It's about spending them
27:27
properly. We manage our context window
27:29
so that we don't waste time and tokens
27:31
correcting our agents mistakes. We want
27:34
oneot outloop agent decoding in a
27:37
massive streak with the fewest attempts
27:39
and large sizes so we can drop our
27:42
presence. Right? In TAC, we use
27:44
specialized agents. We delegated and we
27:47
reduced the context window of our agents
27:49
by building specialized ADWs that
27:52
shipped on our behalf. We built
27:54
specialized agent pipelines. Okay, so
27:56
the big idea here is simple. It's
27:58
measure and manage one of the most
28:00
obviously critical leverage points of
28:02
agent coding, your agents conduct
28:04
window. What's better than a prompt? A
28:05
prompt chain. What's better than a
28:07
prompt chain? An agent. What's better
28:09
than an agent? many focused, specialized
28:12
agents that deliver value for you, for
28:15
your team, and most importantly for your
28:17
customers and users. Don't miss this
28:19
trend. You now have everything you need
28:21
to win and ship with focused
28:23
singlepurposed agents. So all of these
28:26
techniques are us battling with the fact
28:28
that there are key scaling laws and
28:30
algorithms inside of these language
28:32
models, inside of generative AI that
28:34
decreases performance as context window
28:37
grows. What does that mean? It means you
28:38
can safely bet on spending your
28:41
engineering time, energy, and resources
28:43
on investing in great context
28:45
management. In great context
28:47
engineering. It's a safe bet to bet on
28:49
context engineering. There is a lot to
28:51
digest. This lesson is going to be here
28:53
for you. Thank you for trusting me. Keep
28:56
in mind, a focused agent is a performant
28:59
agent.