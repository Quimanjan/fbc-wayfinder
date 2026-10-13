-- FBC Wayfinder tables (prefixed wf_ to keep them apart from FBC PayPoint)
create table if not exists public.wf_places (
  id text primary key,
  name text not null,
  short_label text,
  category text not null check (category in ('office','dept','class','facility','pending')),
  building text,
  description text,
  weekday_open time,
  weekday_close time,
  saturday_open time,
  saturday_close time,
  on_map boolean not null default true,
  sort_order int not null default 0,
  updated_at timestamptz not null default now()
);

create table if not exists public.wf_search_logs (
  id bigint generated always as identity primary key,
  place_id text references public.wf_places(id) on delete set null,
  kiosk text not null default 'lobby',
  created_at timestamptz not null default now()
);

alter table public.wf_places enable row level security;
alter table public.wf_search_logs enable row level security;

drop policy if exists "wf_places public read" on public.wf_places;
create policy "wf_places public read" on public.wf_places for select to anon, authenticated using (true);

drop policy if exists "wf_logs public insert" on public.wf_search_logs;
create policy "wf_logs public insert" on public.wf_search_logs for insert to anon, authenticated with check (place_id is not null);

drop policy if exists "wf_logs public read" on public.wf_search_logs;
create policy "wf_logs public read" on public.wf_search_logs for select to anon, authenticated using (true);

insert into public.wf_places (id, name, short_label, category, building, description, weekday_open, weekday_close, saturday_open, saturday_close, on_map, sort_order) values
('registrar', 'Registrar', 'Registrar', 'office', 'Dr. Demetrio Macasa, Sr. Memorial Building', 'Enrollment, student records, TOR and certificate requests.', '08:00', '17:00', '08:00', '12:00', true, 0),
('hr', 'HR Office', 'HR', 'office', 'Dr. Demetrio Macasa, Sr. Memorial Building', 'Human Resources for faculty and staff.', '08:00', '17:00', '08:00', '12:00', true, 1),
('cashier', 'Cashier', 'Cashier', 'office', 'Dr. Demetrio Macasa, Sr. Memorial Building', 'Tuition and fee payments, official receipts.', '08:00', '17:00', '08:00', '12:00', true, 2),
('lobby', 'Lobby (Entrance)', 'Lobby', 'facility', 'Dr. Demetrio Macasa, Sr. Memorial Building', 'Main entrance and waiting area. The kiosk is here.', null, null, null, null, true, 3),
('idroom', 'ID Room', 'ID Room', 'office', 'Dr. Demetrio Macasa, Sr. Memorial Building', 'Student ID photo capture, printing and replacement.', '08:00', '17:00', '08:00', '12:00', true, 4),
('ahcdept', 'AHC Department', 'AHC Dept', 'dept', 'Dr. Demetrio Macasa, Sr. Memorial Building', 'AHC Department office.', null, null, null, null, true, 5),
('pr2', 'PR 2', 'PR 2', 'class', 'Macasa Building', 'Room PR 2, Macasa Building.', null, null, null, null, true, 6),
('pr1', 'PR 1', 'PR 1', 'class', 'Macasa Building', 'Room PR 1, Macasa Building.', null, null, null, null, true, 7),
('mh5', 'MH 5', 'MH 5', 'class', 'Macasa Building', 'Room MH 5, Macasa Building.', null, null, null, null, true, 8),
('mh6', 'MH 6', 'MH 6', 'class', 'Macasa Building', 'Room MH 6, Macasa Building.', null, null, null, null, true, 9),
('terminal', 'Terminal', 'Terminal', 'facility', 'Terminal', 'Terminal area beside the Macasa Building.', null, null, null, null, true, 10),
('ahcfac', 'AHC Faculty', 'AHC Faculty', 'dept', 'Science Building', 'AHC faculty room, Science Building.', null, null, null, null, true, 11),
('sb101', 'SB 101', 'SB 101', 'class', 'Science Building', 'Room SB 101, Science Building.', null, null, null, null, true, 12),
('sb102', 'SB 102', 'SB 102', 'class', 'Science Building', 'Room SB 102, Science Building.', null, null, null, null, true, 13),
('sb103', 'SB 103', 'SB 103', 'class', 'Science Building', 'Room SB 103, Science Building.', null, null, null, null, true, 14),
('sb104', 'SB 104', 'SB 104', 'class', 'Science Building', 'Room SB 104, Science Building.', null, null, null, null, true, 15),
('osas', 'OSAS', 'OSAS', 'office', 'Science Building', 'Office of Student Affairs and Services.', '08:00', '17:00', '08:00', '12:00', true, 16),
('clinic', 'Clinic', 'Clinic', 'facility', 'Science Building', 'School clinic: first aid and medical clearance.', '08:00', '17:00', '08:00', '12:00', true, 17),
('tr4', 'TR 4', 'TR 4', 'class', 'TR classrooms', 'Classroom TR 4.', null, null, null, null, true, 18),
('tr3', 'TR 3', 'TR 3', 'class', 'TR classrooms', 'Classroom TR 3.', null, null, null, null, true, 19),
('tr2', 'TR 2', 'TR 2', 'class', 'TR classrooms', 'Classroom TR 2.', null, null, null, null, true, 20),
('tr1', 'TR 1', 'TR 1', 'class', 'TR classrooms', 'Classroom TR 1.', null, null, null, null, true, 21),
('tr6', 'TR 6', 'TR 6', 'class', 'TR classrooms', 'Classroom TR 6.', null, null, null, null, true, 22),
('tr5', 'TR 5', 'TR 5', 'class', 'TR classrooms', 'Classroom TR 5.', null, null, null, null, true, 23),
('tr7', 'TR 7', 'TR 7', 'class', 'TR classrooms', 'Classroom TR 7.', null, null, null, null, true, 24),
('tr8', 'TR 8', 'TR 8', 'class', 'TR classrooms', 'Classroom TR 8.', null, null, null, null, true, 25),
('tr9', 'TR 9', 'TR 9', 'class', 'TR classrooms', 'Classroom TR 9.', null, null, null, null, true, 26),
('tr10', 'TR 10', 'TR 10', 'class', 'TR classrooms', 'Classroom TR 10.', null, null, null, null, true, 27),
('tr11', 'TR 11', 'TR 11', 'class', 'TR classrooms', 'Classroom TR 11.', null, null, null, null, true, 28),
('tr12', 'TR 12', 'TR 12', 'class', 'TR classrooms', 'Classroom TR 12.', null, null, null, null, true, 29),
('tr13', 'TR 13', 'TR 13', 'class', 'TR classrooms', 'Classroom TR 13.', null, null, null, null, true, 30),
('tr14', 'TR 14', 'TR 14', 'class', 'TR classrooms', 'Classroom TR 14.', null, null, null, null, true, 31),
('gym', 'Gymnasium', 'Gymnasium', 'facility', 'Gymnasium', 'Assemblies, PE classes and sports events.', null, null, null, null, true, 32),
('assessment', 'Assessment', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 33),
('library', 'Library', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 34),
('cecsdepartment', 'CECS Department', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 35),
('ccjedepartment', 'CCJE Department', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 36),
('cteasdepartment', 'CTEAS Department', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 37),
('chbadepartment', 'CHBA Department', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 38),
('mmit', 'MMIT', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 39),
('comlab1', 'Comlab 1', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 40),
('comlab2', 'Comlab 2', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 41),
('comlab3', 'Comlab 3', null, 'pending', 'Location to be added', 'This place isn''t pinned on the map yet. Ask at the Lobby information desk.', null, null, null, null, false, 42)
on conflict (id) do nothing;
